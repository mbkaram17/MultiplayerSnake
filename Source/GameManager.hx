import flash.Lib;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.Event;
import flash.events.IEventDispatcher;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;
import SnakeIterator;
import Food;
import PlayerIterator;
import SnakePart;

// Game manager takes care of the entire game, including the game loop
class GameManager {

    // Game Data
    public var frameCount:Int = 0 ;
    public static var stage:Stage ;
    public var keyBindings:Array<KeyBinding> ;
    public var totalSnakeArea:Int ; // one snake part occupies 24 pixles

    // Player Data
    public var numPlayers:Int ;
    public var playerList:Array<Player> ;
    public var playerIterator:PlayerIterator ; // Iterator used many times, so it is stored.
    public var snakeSpeed:Float ;
    public var frameSpeed:Float ;
    public var numPlayersAlive:Int ;

    public var head:SnakePart ;

    // Other Data
    public var food:Food ;

    public function new(numPlayers:Int, snakeSpeed:Float, frameSpeed:Float)
    {
        this.numPlayers = numPlayers ;
        this.numPlayersAlive = numPlayers ;
        this.snakeSpeed = snakeSpeed ;
        this.playerList = new Array<Player>() ;
        this.playerIterator = new PlayerIterator(playerList) ;
        this.frameSpeed = frameSpeed ;
        this.totalSnakeArea = numPlayers * 3 * 24; // the game will end when the screen is ALMOST full

        keyBindings = Main.createKeyBindings() ;
        stage = Lib.current.stage;

        // Event Listeners
        stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed) ;
        stage.addEventListener(Event.ENTER_FRAME, updateGame) ;

    }

    // Start game initializes players, food and listeners
    public function startGame():Void
    {

        // Initialize Players
        initializePlayers() ;

        // Create the food
        createFood() ;

    }

    public function updateGame(event:Event):Void
    {
        frameCount++ ;

        if(numPlayersAlive <= 0 || totalSnakeArea >= stage.stageWidth * stage.stageHeight) // if all players died, or the screen is full
        {
            resetGame() ;
        }

        if(frameCount % frameSpeed == 0) // Frame rate speed
        {
            // Move Each snake body
            for(player in playerIterator)
            {
                var snakeIterator = new SnakeIterator(player.playerSnake) ;
                var previousPartX:Float = player.playerSnakeHead.sprite.x ;
                var previousPartY:Float = player.playerSnakeHead.sprite.y ;
                for(currentPart in snakeIterator)
                {
                    var tempPartX:Float = currentPart.sprite.x ;
                    var tempPartY:Float = currentPart.sprite.y ;

                    currentPart.sprite.x = previousPartX ;
                    currentPart.sprite.y = previousPartY ;

                    previousPartX = tempPartX ;
                    previousPartY = tempPartY ;
                }

                switch(player.currentDirection)
                {
                    case Left: player.playerSnakeHead.sprite.x -= snakeSpeed ;
                    case Right: player.playerSnakeHead.sprite.x += snakeSpeed  ;
                    case Up: player.playerSnakeHead.sprite.y -= snakeSpeed  ;
                    case Down: player.playerSnakeHead.sprite.y += snakeSpeed  ;
                    case Still:
                       player.playerSnakeHead.sprite.y = player.playerSnakeHead.sprite.y;
                       player.playerSnakeHead.sprite.x = player.playerSnakeHead.sprite.x;
                }
            }

            // Check to see if any snakes hit a wall
            for(player in playerIterator)
            {
                // intersect with walls on the sides
                if (player.playerSnakeHead.sprite.x + player.playerSnakeHead.sprite.width >= stage.stageWidth
                    || player.playerSnakeHead.sprite.x < 0)
                {
                    removePlayer(player) ;
                }

                // intersect with top or bottom walls
                if (player.playerSnakeHead.sprite.y + player.playerSnakeHead.sprite.height >= stage.stageHeight
                    || player.playerSnakeHead.sprite.y < 0)
                {
                    removePlayer(player) ;
                }
            }

            // Check to see if snakes hit selfs or others
            for(currentPlayer in playerIterator)
            {
                for(otherPlayer in playerIterator)
                {
                    var snakeIterator:SnakeIterator = new SnakeIterator(otherPlayer.playerSnake) ;
                    for(otherPlayerSnakePart in snakeIterator)
                    {
                        if(currentPlayer.playerSnakeHead.sprite.x == otherPlayerSnakePart.sprite.x &&
                            currentPlayer.playerSnakeHead.sprite.y == otherPlayerSnakePart.sprite.y &&
                            currentPlayer.playerSnakeHead != otherPlayerSnakePart)
                        {
                            removePlayer(currentPlayer) ;
                        }
                    }
                }
            }

            // Check to see if any snakes hit the apple
            for(player in playerIterator)
            {
                totalSnakeArea += 24 ; //player hit an apple, area of all snakes goes up
                if(player.playerSnakeHead.sprite.hitTestObject(food.sprite))
                {
                    stage.removeChild(food.sprite) ;
                    createFood() ;
                    var bodyPart:SnakePart = new SnakePart() ;
                    bodyPart.sprite.x = player.playerSnake[player.playerSnake.length - 1].sprite.x ;
                    bodyPart.sprite.y = player.playerSnake[player.playerSnake.length - 1].sprite.y ;
                    player.playerSnake.push(bodyPart) ;
                    stage.addChild(bodyPart.sprite) ;
                }
            }
        }
    }

    // Function to initialize the number of players defined
    public function initializePlayers()
    {
        for(i in 1...numPlayers + 1)
        {
            if(keyBindings.length > 0)
            {
                var newPlayer:Player = new Player(i, keyBindings[0]) ;
                keyBindings.remove(keyBindings[0]) ;
                playerList.push(newPlayer) ;
            }
        }

        for(player in playerIterator)
        {
            player.playerSnakeHead.sprite.x = ((stage.stageWidth - 10) / (playerList.length + 1)) * player.playerNumber ;
            player.playerSnakeHead.sprite.y = (stage.stageHeight - 10) / 2 ;
            stage.addChild(player.playerSnakeHead.sprite) ;
        }
    }

    public function createFood()
    {
        food = new Food() ;
        food.sprite.x = 50 + Math.random()*(stage.stageWidth-100);
        food.sprite.y = 50 + Math.random()*(stage.stageHeight-100);
        stage.addChild(food.sprite);
    }

    public function keyPressed (event:KeyboardEvent):Void
    {
        for(player in playerIterator)
        {
            player.changeDirection(event.keyCode) ;
        }
    }

    // remove a player
    public function removePlayer(deadPlayer:Player)
    {
        var snakeIterator:SnakeIterator = new SnakeIterator(deadPlayer.playerSnake) ;
        for(snakePart in snakeIterator)
        {
            stage.removeChild(snakePart.sprite) ;
            snakePart = null ;
            totalSnakeArea -= 24 ; // Player died, remove area of snake
        }
        playerList.remove(deadPlayer) ;
        numPlayersAlive-- ;
        deadPlayer = null ;
    }

    public function resetGame()
    {
        // Remove all players if the game was won
        if(numPlayersAlive > 0)
        {
            var playerIterator:PlayerIterator = new PlayerIterator(playerList) ;
            for(player in playerIterator)
            {
                removePlayer(player) ;
            }
        }

        // Remove the Food
        stage.removeChild(food.sprite) ;
        food = null ;

        // Reset all variables
        numPlayersAlive = numPlayers ;
        keyBindings = new Array<KeyBinding>() ;
        keyBindings = Main.createKeyBindings() ;

        // Start the game again
        startGame() ;

    }
}
