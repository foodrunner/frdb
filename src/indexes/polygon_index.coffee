IDSet = require('../id_set')
Helper = require('../helper')
PolygonIndex = require('rbush')

# A polygon looks like this {id: 1, group: 1, location: [x, y], points: [[x, y], [x1, y1]]}

PolygonIndex::add = (group_id, polygons) ->
  polygons = [polygons] unless polygons instanceof Array
  for polygon in polygons
    polygon.group = group_id
    @insert(polygon)
  null

PolygonIndex::search = (target) ->
  node = @data
  groups = {}
  set = new IDSet()
  return set unless @_inside(target, node.bbox)
  nodesToSearch = []
  while node?
    for child in node.children
      childBBox = if node.leaf then @toBBox(child) else child.bbox
      if node.leaf?
        d = Helper.distanceBetween(child.location, target)
        if !groups[child.group]? 
          groups[child.group] = {dist: d, polygon: child} 
        else if @_further(groups[child.group].dist, d) and @_hitByRaycast(target, child)
          groups[child.group].dist = d
          groups[child.group].polygon = child
      else if @_inside(target, childBBox)
        nodesToSearch.push(child);
    node = nodesToSearch.pop()
  set.add(group) for group of groups
  set

PolygonIndex::toBBox = (polygon) ->
  minX = polygon.points[0][0]
  minY = polygon.points[0][1]
  maxX = minX
  maxY = minY
  for p in polygon.points
    minX = Math.min(minX, p[0])
    minY = Math.min(minY, p[1])
    maxX = Math.max(maxX, p[0])
    maxY = Math.max(maxY, p[1])
  [minX, minY, maxX, maxY]

PolygonIndex::_inside = (target, bbox) ->
  target[0] > bbox[0] and 
  target[1] > bbox[1] and
  target[0] < bbox[2] and
  target[1] < bbox[3]

PolygonIndex::_hitByRaycast = (target, polygon) ->
  return false unless @_inside(target, @toBBox(polygon))
  Helper.hitByRaycast(target, polygon.points)

PolygonIndex::_further = (current, target) ->
  return false if current < 1000
  current > target

module.exports = PolygonIndex