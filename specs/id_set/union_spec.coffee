IDSet = require ('../../src/id_set')

describe 'IDSet', ->
  describe 'union', ->

      it '2 sets', ->
        r1 = new IDSet(['1m', '2m'])
        r2 = new IDSet(['1m', '3m', '5m'])
        h = IDSet.union([r1, r2])
        expect(h.count).toBe(4)
        expect(h.ids['1m']).toBe(true)
        expect(h.ids['2m']).toBe(true)
        expect(h.ids['3m']).toBe(true)
        expect(h.ids['5m']).toBe(true)