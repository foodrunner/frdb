Result = require ('../../../src/result')
PolygonIndex = require ('../../../src/indexes/polygon_index')

describe 'PolygonIndex', ->
  describe 'search', ->

    it 'returns empty when not found', ->
      rmap = new PolygonIndex()
      p1 = {id: '1b', group: '1m', location: [1, 1], points: [[1, 0], [2, 1], [0, 2], [2, 2], [3, 0]]}
      p2 = {id: '2b', group: '2m', location: [3, 1], points: [[2, 0], [2, 2], [4, 2], [4, 0], [2, 0]]}
      rmap.add('1b', p1)
      rmap.add('2b', p2)
      result = rmap.search([5, 6])
      expect(result.count).toEqual(0)

    it 'returns polygons from different groups', ->
      rmap = new PolygonIndex()
      p1 = {id: '1b', group: '1m', location: [1, 1], points: [[1, 0], [2, 1], [0, 2], [2, 2], [3, 0]]}
      p2 = {id: '2b', group: '2m', location: [3, 1], points: [[2, 0], [2, 2], [4, 2], [4, 0], [2, 0]]}
      rmap.add('1b', p1)
      rmap.add('2b', p2)
      result = rmap.search([2.5, 0.5])
      expect(result.count).toEqual(2)

    it 'returns only the group ids', ->
      rmap = new PolygonIndex()
      p1 = {id: '1b', location: [1, 1], points: [[1, 0], [2, 1], [0, 2], [2, 2], [3, 0]]}
      p2 = {id: '2b', location: [3, 1], points: [[2, 0], [2, 2], [4, 2], [4, 0], [2, 0]]}
      rmap.add('1m', [p1, p2])
      spyOn(rmap, '_further').andReturn(true)
      result = rmap.search([2.5, 0.5])
      expect(result.count).toEqual(1)
      expect(result.ids['1m']).toEqual(true)
