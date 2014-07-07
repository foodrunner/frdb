Result = require ('../../src/result')

describe 'result', ->
  describe 'intersect', ->

    it '2 sets without common ids', ->
      r1 = new Result(['1m', '2m'])
      r2 = new Result(['3m', '4m', '5m'])
      r = Result.intersect([r1, r2])
      expect(r.count).toBe(0)
      expect(r.ids).toEqual({})

    it '2 sets with some common ids', ->
      r1 = new Result(['1m', '2m'])
      r2 = new Result(['1m', '4m', '5m'])
      r = Result.intersect([r1, r2])
      expect(r.count).toBe(1)
      expect(r.ids['1m']).toBe(true)