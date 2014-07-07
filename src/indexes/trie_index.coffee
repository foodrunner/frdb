Result = require('../result')

normalization_pattern = new RegExp('[^a-zA-Z ]', 'g')
spaces = new RegExp(' ', 'g')
empty = []

class TrieIndex
  constructor: () ->
    @root = {}

  add: (id, text) ->
    words = TrieIndex.normalize(text).split(' ')
    for i in [0..words.length]
      word = ""
      word += w for w in words.slice(i)
      @index(id, word)
    null

  search: (value) ->
    node = @root
    for c in TrieIndex.normalize(value).replace(spaces, '')
      return empty unless node[c]
      node = node[c]
    node['$'] || new Result()

  index: (id, word) ->
    node = @root
    for c in word
      node[c] = {'$': new Result()} unless node[c]
      node[c]['$'].add(id)
      node = node[c]
    return

  @normalize: (text) ->
    text.replace(normalization_pattern, '').toLowerCase()

module.exports = TrieIndex
