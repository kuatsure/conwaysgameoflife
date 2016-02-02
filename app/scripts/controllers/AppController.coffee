'use strict'

angular
  .module('conwaysGameOfLifeApp')
  .controller 'AppController',
    [ '$interval',
    (  $interval )->

      # define private functions
      _init = ( height, width, random ) ->
        board = []


        for [ 0...height ]
          row = []

          for [ 0...width ]
            if random
              row.push Math.random() >= 0.5

            else
              row.push false

          board.push row

        return board

      _checkForEndGame = ( prevCount, newCount ) =>
        if newCount is prevCount
          @isItOver = true

        if newCount is 0
          @isItOver = true

      _traverseBoardForNeighbors = ( board ) ->
        totalCount = 0

        for r in [ 0...board.length ]
          for c in [ 0...board[r].length ]
            count = _neighborCount board, r, c

            totalCount += count

        return totalCount

      _figureNextGeneration = ( board ) ->
        newBoard = []

        prevCount = _traverseBoardForNeighbors board

        for r in [ 0...board.length ]
          newRow = []

          for c in [ 0...board[r].length ]
            newRow.push _willLive( board, r, c ) or _newCell( board, r, c )

          newBoard.push newRow

        newCount = _traverseBoardForNeighbors newBoard

        _checkForEndGame prevCount, newCount

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
      @height         = 15
      @width          = 15
      @interval       = 1500

      @random         = false
      @auto           = false

      @autoGenerate   = false

      @isItOver       = false

      # define public functions
      @newGame = ->
        @history  = []
        @board    = _init @height, @width, @random
        @isItOver = false

      @stopAutoRun = ->
        $interval.cancel @autoGenerate
        @auto = !@auto

      @nextGeneration = ->
        unless @isItOver
          @history.push @board

          @board = _figureNextGeneration @board unless @auto

          if @auto
            @autoGenerate = $interval ( =>
              @history.push @board

              @board = _figureNextGeneration @board

              # Check to see if the game is over
              # if it is kill the interval
              if @isItOver
                $interval.cancel @autoGenerate

                @auto = !@auto

              return
            ), @interval

      @previousGeneration = ( index ) ->
        @board    = @history[index]

        @history  = @history.slice 0, index

        # game isn't over since it went back in time
        @isItOver   = false

      @toggleCell = ( row, cell ) ->
        # reset history
        @history    = []

        # game isn't over since it restarted
        @isItOver   = false

        @board[row][cell] = !@board[row][cell]

        if @auto
          @auto = !@auto

          $interval.cancel @autoGenerate

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
