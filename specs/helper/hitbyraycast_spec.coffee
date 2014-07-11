Helper = require ('../../src/helper')

describe 'Helper', ->
  describe 'hitByRaycast', ->

    it 'returns true when target inside the polygon', ->
      polygon = [[1, 0], [3, 0], [2, 2], [0, 2], [2, 1], [1, 0]]
      expect(Helper.hitByRaycast([2.2, 1], polygon)).toEqual(true)

    it 'returns false when target outside of the polygon', ->
      polygon = [[1, 0], [2, 1], [0, 2], [2, 2], [3, 0]]
      expect(Helper.hitByRaycast([1, 0], polygon)).toEqual(false)
      expect(Helper.hitByRaycast([2, 3], polygon)).toEqual(false)
      expect(Helper.hitByRaycast([10, 2], polygon)).toEqual(false)
