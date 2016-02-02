'use strict'

angular
  .module('conwaysGameOfLifeApp')
  .controller 'AppController',
    [ '$interval',
    (  $interval )->

      # define private functions
      _init = ( height, width ) ->
        board = []


        for [ 0...height ]
          row = []

          for [ 0...width ]
            row.push false

          board.push row

        return board

      _figureNextGeneration = ( board ) ->
        newBoard = []

        for r in [ 0...board.length ]
          newRow = []

          for c in [ 0...board[r].length ]
            newRow.push _willLive( board, r, c ) or _newCell( board, r, c )

          newBoard.push newRow

        return newBoard

      _willLive = ( board, row, cell ) ->
        _cellAt( board, row, cell ) and
        _neighborCount( board, row, cell ) >= 2 and
        _neighborCount( board, row, cell ) <= 3

      _willDie = ( board, row, cell ) ->
        _cellAt( board, row, cell ) and
        (
          _neighborCount( board, row, cell ) < 2 or
          _neighborCount( board, row, cell ) > 3
        )

      _newCell = ( board, row, cell ) ->
        !_cellAt( board, row, cell ) and
        _neighborCount( board, row, cell ) == 3

      _neighborCount = ( board, row, cell ) ->
        n = 0
        n += if _cellAt( board, row - 1, cell - 1 ) then 1 else 0
        n += if _cellAt( board, row - 1, cell + 0 ) then 1 else 0
        n += if _cellAt( board, row - 1, cell + 1 ) then 1 else 0
        n += if _cellAt( board, row + 0, cell - 1 ) then 1 else 0
        n += if _cellAt( board, row + 0, cell + 1 ) then 1 else 0
        n += if _cellAt( board, row + 1, cell - 1 ) then 1 else 0
        n += if _cellAt( board, row + 1, cell + 0 ) then 1 else 0
        n += if _cellAt( board, row + 1, cell + 1 ) then 1 else 0
        n

      _cellAt = ( board, row, cell ) ->
        row >= 0 and row < board.length and cell >= 0 and cell < board[row].length and board[row][cell]

      # Assign simple scoped variables
      @height   = 15
      @width    = 15

      @random   = false
      @auto     = false

      # define public functions
      @newGame = ->
        @history  = []
        @board    = _init @height, @width, @random

      @nextGeneration = ->
        @history.push @board

        @board = _figureNextGeneration @board unless @auto

        if @auto
          $interval ( =>
            @history.push @board

            @board = _figureNextGeneration @board

            return
          ), 1500

      @previousGeneration = ( index ) ->
        @board    = @history[index]

        @history  = @history.slice 0, index

      @toggleCell = ( row, cell ) ->
        # reset history
        @history = []

        @board[row][cell] = !@board[row][cell]

      @cellClass = ( row, cell ) ->
        selector = ''

        if _willDie @board, row, cell
          selector = 'will-die'

        if _newCell @board, row, cell
          selector = 'will-new'

        selector

      # Start the game
      @newGame()

      # return controller ref
      return @
]
