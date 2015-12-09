package {
    import flash.display.Sprite;
    import flash.display.LineScaleMode;
    import flash.display.CapsStyle;
    import flash.display.JointStyle;
    import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.events.Event;

    public class drawer extends Sprite {
		
		public var shaping:Boolean = false;		
		public var closePoint:Object = new Object();
		public var drawing:Shape = new Shape();
		public var closePointGuide:Shape = new Shape();
		public var lastPointGuide:Shape = new Shape();
		
        public function drawer() {
			closePoint.x = 0;
			closePoint.y = 0;
			drawing.graphics.lineStyle(3, 0x000000, 1, false, LineScaleMode.NONE, CapsStyle.ROUND, JointStyle.ROUND, 3);
			drawing.graphics.beginFill(0xffffff, 1); 
			this.addChild(drawing);
			
			lastPointGuide.graphics.lineStyle(3, 0x000000, 1, false, LineScaleMode.NONE, CapsStyle.ROUND, JointStyle.ROUND, 3);
			lastPointGuide.graphics.moveTo(0,0);
			lastPointGuide.graphics.lineTo(100,100);
			lastPointGuide.visible = false;
			this.addChild(lastPointGuide);
			
			closePointGuide.graphics.lineStyle(3, 0x000000, 1, false, LineScaleMode.NONE, CapsStyle.ROUND, JointStyle.ROUND, 3);
			closePointGuide.graphics.moveTo(0,0);
			closePointGuide.graphics.lineTo(100,100);
			closePointGuide.visible = false;
			this.addChild(closePointGuide);
            
			stage.addEventListener(MouseEvent.CLICK, onClick);
			stage.doubleClickEnabled  = true;
			stage.addEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClick);
			this.addEventListener(Event.ENTER_FRAME, animationLoop);
		}
		
		private function onClick(e:MouseEvent):void
		{
			if(shaping){
				drawing.graphics.lineTo(stage.mouseX, stage.mouseY);
			}else{
				drawing.graphics.moveTo(stage.mouseX, stage.mouseY);
				closePoint.x = stage.mouseX;
				closePoint.y = stage.mouseY;
				shaping = true;
				closePointGuide.visible = true;
				lastPointGuide.visible = true;
			}
			lastPointGuide.x = stage.mouseX;
			lastPointGuide.y = stage.mouseY;
		}
		
		private function onDoubleClick(e:MouseEvent):void
		{
			if(shaping){
				drawing.graphics.lineTo(closePoint.x, closePoint.y);
				drawing.graphics.endFill();
				drawing.graphics.beginFill(0xffffff, 1);
				shaping = false;
				closePointGuide.visible = false;
				lastPointGuide.visible = false;
			}
			lastPointGuide.x = stage.mouseX;
			lastPointGuide.y = stage.mouseY;
		}
		
		private function animationLoop(e:Event):void
		{
			closePointGuide.x = closePoint.x;
			closePointGuide.y = closePoint.y;
			closePointGuide.scaleX = (stage.mouseX - closePoint.x)/100;
			closePointGuide.scaleY = (stage.mouseY - closePoint.y)/100;
			lastPointGuide.scaleX = (stage.mouseX - lastPointGuide.x)/100;
			lastPointGuide.scaleY = (stage.mouseY - lastPointGuide.y)/100;
		}
    }
}