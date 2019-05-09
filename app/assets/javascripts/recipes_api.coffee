# This was a convention invented by me, but I like it: Use underscore for variables and camelCase for functions

class @RecipesApi
  constructor: (input_wrapper_selector) ->
    @base_url = '/proxy'
    @ingredients = []
    @query = ''

    @input_wraper = $ input_wrapper_selector
    @query_input = $ '.query-input', @input_wraper
    @debouncedFetch = _.debounce @fetch, 500
    @query_input.on 'keyup', @debouncedFetch
    @results_table = $ '.results-table', @input_wraper
    @last_query = ''

  # addIngredient: (ingredient) ->
  # removeIngredient: (ingredient) ->

  fetch: =>
    query = @query_input.val().trim()
    return if query.length == 0 or query == @last_query

    @lockResultsTable()
    @last_query = query

    url = "#{@base_url}?query=#{query}"

    $.get url, @complete

  complete: (results) =>
    @results_table.html @buildHtml results

  buildHtml: (results) ->
    _.map(results, @buildItemHtml)

  buildItemHtml: (item) ->
    "<tr><td><a href='#{item.href}' target='blank'>#{item.title}</a></td></tr>"

  lockResultsTable: ->
    @results_table.html '<tr><td><div class="ui large text active centered inline loader">Loading</div></td></tr>'
    @results_table.fadeIn()
