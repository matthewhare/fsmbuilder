package utils.autoupdate
{
	import flash.desktop.NativeApplication;

	public class AutoUpdater
	{
		public function AutoUpdater()
		{
		}
		
		import air.update.events.UpdateEvent;
		import mx.controls.Alert; 
		import flash.events.ErrorEvent; 
		import air.update.ApplicationUpdaterUI; /** * @var the object that that handles the update related actions */ 
		
		static private var appUpdater:ApplicationUpdaterUI = new ApplicationUpdaterUI(); 
		
		/** This function is triggered when the application finished to load; 
		 * Here we initialize <code>appUpdater</code> and set some properties 
		 **/ 
		
		static private function checkUpdate():void 
		{ 
			setApplicationVersion(); 
			// we set the URL for the update.xml file 
//			https://raw.github.com/matthewhare/fsmbuilder/master/updater/update.xml
			appUpdater.updateURL = "https://raw.github.com/matthewhare/fsmbuilder/master/updater/update.xml"; 
			//we set the event handlers for INITIALIZED nad ERROR 
			appUpdater.addEventListener(UpdateEvent.INITIALIZED, onUpdate); 
			appUpdater.addEventListener(ErrorEvent.ERROR, onError); 
			//we can hide the dialog asking for permission for checking for a new update;
			//if you want to see it just leave the default value (or set true).
			appUpdater.isCheckForUpdateVisible = false; 
			//if isFileUpdateVisible is set to true, File Update, File No Update, //
			// and File Error dialog boxes will be displayed appUpdater.isFileUpdateVisible = false; 
			//if isInstallUpdateVisible is set to true, the dialog box for installing the update is visible 
			appUpdater.isInstallUpdateVisible = false; 
			//we initialize the updater 
			appUpdater.initialize(); 
		} 
		
		/** 
		 * * Handler function triggered by the ApplicationUpdater.initialize; 
		 * * The updater was initialized and it is ready to take commands 
		 * * (such as <code>checkNow()</code> 
		 * * @param UpdateEvent 
		 * */ 
		static private function onUpdate(event:UpdateEvent):void 
		{ 
			//start the process of checking for a new update and to install 
			appUpdater.checkNow(); 
		}
		
		/** 
		 * * Handler function for error events triggered by the ApplicationUpdater.initialize 
		 * * @param ErrorEvent 
		 * */ 
		static private function onError(event:ErrorEvent):void 
		{ 
			Alert.show(event.toString()); 
		} 
		
		/** 
		 * * A simple code just to read the current version of the application 
		 * * and display it in a label. 
		 * */ 
		static private function setApplicationVersion():void 
		{ 
			var appXML:XML = NativeApplication.nativeApplication.applicationDescriptor; 
			var ns:Namespace = appXML.namespace(); 
			AutoUpdater.version = "App version:" + appXML.ns::version; 
		} 
		
		[Bindable]
		static public var version:String = "checking..";
	}
}