PolygonIndex = require ('../../../src/indexes/polygon_index')

describe 'PolygonIndex', ->
  describe 'toBBox', ->

    it 'returns bounding box', ->
      rmap = new PolygonIndex()
      polygon = {id: '1b', group: '1m', location: [1, 1], points: [[1, 0], [2, 1], [0, 2], [2, 2], [3, 0]]}
      expect(rmap.toBBox(polygon)).toEqual([0, 0, 3, 2])
