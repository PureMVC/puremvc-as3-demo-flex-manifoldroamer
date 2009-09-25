package org.puremvc.manifoldroamer.controller
{
	//import org.puremvc.manifoldroamer.model.UPSProxy;
	import org.puremvc.manifoldroamer.view.RoamerMediator;
	
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	
	import org.puremvc.manifoldroamer.view.ApplicationMediator;
	import org.puremvc.manifoldroamer.view.ContentExplorerMediator;
	import org.puremvc.manifoldroamer.model.ManifoldProxy;
	import org.puremvc.manifoldroamer.model.GraphProxy;
	import org.puremvc.manifoldroamer.model.ConfigProxy;

	public class StartupCommand extends SimpleCommand implements ICommand
	{
			
        /**
         * Register the Proxies and Mediators.
         * 
         * Get the View Components for the Mediators from the app,
         * which passed a reference to itself on the notification.
         */
        override public function execute( note:INotification ) : void    
        {

			// The application mediator handles communications with the main Application 
            var app:ManifoldRoamer = note.getBody() as ManifoldRoamer;
            
			// register proxies 
            facade.registerProxy( new ConfigProxy() );
            facade.registerProxy( new GraphProxy() );
            facade.registerProxy( new ManifoldProxy() );
            
            //facade.registerMediator( new ApplicationMediator( app ) );
            facade.registerMediator( new RoamerMediator( app.roamer ) );
            facade.registerMediator( new ContentExplorerMediator( app.explorer ) );
        }
		
	}
}