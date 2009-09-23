package org.puremvc.manifoldroamer.controller
{
	import com.adobe.flex.extras.controls.springgraph.Item;

	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	import org.puremvc.manifoldroamer.view.components.Roamer;
	import org.puremvc.manifoldroamer.ApplicationFacade;
	import org.puremvc.manifoldroamer.model.UPSProxy;

	public class ConfigReadyCommand extends SimpleCommand implements ICommand
	{
        /**
         * When configuration has been retrieved, inititialize the 
         * UPSProxy's root node
         */
        override public function execute( note:INotification ) : void    
        {
        	var upsProxy:UPSProxy = facade.retrieveProxy( UPSProxy.NAME ) as UPSProxy;
        	upsProxy.initializeRoot();
        }
		
	}
}