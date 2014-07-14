Helper = require ('../../src/helper')

describe 'Helper', ->
  describe 'clone', ->

    it 'can freely mutate the clone', ->
      a = {x: 4, y: 6}
      b = Helper.clone(a)
      expect(b.x).toEqual(4)
      expect(b.y).toEqual(6)
      b.y = 10
      expect(a.y).toEqual(6)
      expect(b.y).toEqual(10)
