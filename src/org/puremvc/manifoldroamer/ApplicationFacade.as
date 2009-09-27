package org.puremvc.manifoldroamer
{
	import org.puremvc.as3.patterns.facade.Facade;
	import org.puremvc.manifoldroamer.controller.*;
	import org.puremvc.manifoldroamer.model.ConfigProxy;

	public class ApplicationFacade extends Facade
	{

        // Notification and Event name constants
        public static const STARTUP:String   		= "startup";
        public static const RESET:String 			= "reset";
        public static const NODE_CLICK:String 		= "nodeClick";
        public static const NODE_SELECTED:String 	= "nodeSelected";
        public static const NODE_EXPANDED:String 	= "nodeExpanded";
        public static const SHOW_HISTORY:String 	= "showHistory";
        public static const SHOW_CONTENT:String 	= "showContent";
        public static const HIDE_CONTENT:String 	= "hideContent";
        public static const SCALE_GRAPH:String 		= "scaleGraph";
               
        /**
         * Singleton ApplicationFacade Factory Method
         */
        public static function getInstance() : ApplicationFacade {
            if ( instance == null ) instance = new ApplicationFacade( );
            return instance as ApplicationFacade;
        }

        /**
         * Register Commands with the Controller 
         */
        override protected function initializeController( ) : void 
        {
            super.initializeController();            
            registerCommand( STARTUP, StartupCommand );
            registerCommand( NODE_CLICK, NodeClickCommand );
            registerCommand( NODE_SELECTED, NodeSelectedCommand );
            registerCommand( NODE_EXPANDED, NodeExpandedCommand );
            registerCommand( ConfigProxy.CONFIG_READY, ConfigReadyCommand );
        }
        
        /**
         * Application startup
         * 
         * @param app a reference to the application component 
         */  
        public function startup( app:ManifoldRoamer ):void
        {
        	sendNotification( STARTUP, app );
        }


	}
}