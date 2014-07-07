PolygonIndex = require ('../../../src/indexes/polygon_index')

describe 'PolygonIndex', ->
  describe 'hitByRaycast', ->

    it 'returns true when target inside the polygon', ->
      rmap = new PolygonIndex()
      polygon = {id: '1b', group: '1m', location: [1, 1], points: [[1, 0], [3, 0], [2, 2], [0, 2], [2, 1], [1, 0]]}
      expect(rmap._hitByRaycast([2.2, 1], polygon)).toEqual(true)

    it 'returns false when target outside of the polygon', ->
      rmap = new PolygonIndex()
      polygon = {id: '1b', group: '1m', location: [1, 1], points: [[1, 0], [2, 1], [0, 2], [2, 2], [3, 0]]}
      expect(rmap._hitByRaycast([1, 0], polygon)).toEqual(false)
      expect(rmap._hitByRaycast([2, 2], polygon)).toEqual(false)
      expect(rmap._hitByRaycast([10, 2], polygon)).toEqual(false)
