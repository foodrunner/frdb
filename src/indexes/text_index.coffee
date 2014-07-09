natural = require('natural')
IDSet = require('../id_set')
SetIndex = require('./set_index')

normalization_pattern = new RegExp('[^a-zA-Z ]', 'g')
spaces = new RegExp(' +', 'g')
empty = []
blacklist = {"the": true, "be": true, "to": true, "of": true, "and": true, "in": true, "that": true, "have": true, "it": true, "not": true, "on": true, "with": true, "he": true, "as": true, "you": true, "do": true, "at": true, "this": true, "but": true, "his": true, "by": true, "from": true, "for": true, "are": true, "serve": true, "dish": true, "dishes": true, "restaurant": true, "restaurants": true, "its": true, "your": true, "all": true, "an": true, "is": true, "food": true, "serv": true, "cuisine": true}

class TextIndex
  constructor: () ->
    @set = new SetIndex()

  add: (id, texts) ->
    texts = if texts instanceof Array then texts else [texts]
    for text in texts
      tokens = TextIndex.normalize(text).split(' ')
      @index(id, word) for word in tokens
    null

  search: (text) ->
    tokens = TextIndex.normalize(text).split(' ')
    IDSet.intersect(@set.search(TextIndex.variants(token)) for token in tokens)

  index: (id, word) ->
    return if blacklist[word]?
    @set.add(id, TextIndex.variants(word))

  @normalize: (text) ->
    text.replace(normalization_pattern, '').replace(spaces, ' ').trim().toLowerCase()

  @variants: (word) ->
    arr = [word]
    stemmed = natural.PorterStemmer.stem(word)
    arr.push(stemmed) if stemmed isnt word
    arr

module.exports = TextIndex
