
should = require 'should'
each = if process.env.EACH_COV then require '../lib-cov/each' else require '../lib/each'

describe 'Unshift', ->

  it 'accept array elements', (next) ->
    each()
    .unshift('hello')
    .unshift('each')
    .on 'item', (item, index, next) ->
      item.should.eql 'each' if index is 0
      next()
    .on 'both', (err, count) ->
      should.not.exist err
      count.should.eql 2
      next()

  it 'accept key value elements', (next) ->
    each()
    .unshift('hello', 'each')
    .unshift('youre', 'welcome')
    .on 'item', (key, value, next) ->
      value.should.eql 'welcome' if key is 'youre'
      next()
    .on 'both', (err, count) ->
      should.not.exist err
      count.should.eql 2
      next()

  it 'should place the next element', (next) ->
    last = null
    e = each(['a','b','c'])
    .on 'item', (value, next) ->
      if value is 'a'
        e.unshift 'aa'
      if last is 'a'
        value.should.eql 'aa'
      if last is 'aa'
        value.should.eql 'b'
      last = value
      next()
    .on 'both', (err, count) ->
      should.not.exist err
      count.should.eql 4
      next()
