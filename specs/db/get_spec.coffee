DB = require('../../src/db')

describe 'DB', ->
  describe 'get', ->
    it 'return null for non-existing item', ->
      db = new DB()
      expect(db.get('1m')).toBeNull()

    it 'return existing item', ->
      db = new DB()
      db.add({id: '1m', value: 2}, {})
      expect(db.get('1m').value).toEqual(2)
