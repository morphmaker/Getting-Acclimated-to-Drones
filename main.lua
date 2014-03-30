--[[Getting Acclimated to Drones
Sara Levine
for CCTP645 Poetics of Mobile
	with help from the following resources:
	http://coronalabs.com/blog/2013/11/05/tutorial-captureselect-photo-and-video/
	http://docs.coronalabs.com/api/event/touch/index.html
	http://docs.coronalabs.com/api/library/media/selectPhoto.html
	https://docs.coronalabs.com/api/library/widget/newButton.html]]

display.setStatusBar(display.HiddenStatusBar)
local widget = require( "widget" )
--function for displaying the photo
local function onPhotoComplete( event )
	if ( event.completed ) then
		local photo = event.target
		--scale the photo down
		local s = display.contentHeight / photo.contentHeight
		photo:scale( s,s )
		--position the photo
		photo.x=150
		photo.y=250
		print ( "photo w,h =" .. photo.width .. "," .. photo.height )
	end
	--first drone specs, position the drone randomly along the y-axis
	local drone1 = display.newImage("drone1.png")
	drone1:scale(.2,.2)
	drone1.x=display.contentWidth*.2
	drone1.y=math.random(50,120)
	--second drone specs, position the drone randomly along the y-axis
	local drone2 = display.newImage("drone2.png")
	drone2:scale(.15,.15)
	drone2.x=display.contentWidth*.9
	drone2.y=math.random(40,280)
--if the button is pressed then restart the photo-taking function
local function handleButtonEvent( event )

    if ( "ended" == event.phase ) then
       if (media.hasSource( media.Camera ) ) then
	media.capturePhoto( { listener = onPhotoComplete } )
else
	native.showAlert( "Corona", "This device does not have a camera.", {"OK" } ) 
end
    end
end

-- specs for the button, including width, height, image files, label, etc.
local button1 = widget.newButton
{
    width = 100,
    height = 60,
    defaultFile = "buttonDefault.png",
    overFile = "buttonOver.png",
    label = "button",
    onEvent = handleButtonEvent,
    labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0, 0.5 } },
    labelYOffset = -5
}
button1.x=display.contentWidth/2
button1.y=display.contentHeight-50
button1:setLabel("Retake!")
end
--takes the picture
if (media.hasSource( media.Camera ) ) then
	media.capturePhoto( { listener = onPhotoComplete } )
else
	native.showAlert( "Corona", "This device does not have a camera.", {"OK" } ) 
end
--saves the picture
media.capturePhoto ( {
	listener = onPhotoComplete,
	destination = {
	baseDir = system.TemporaryDirectory,
	filename = "myImage.jpg",
	type = "image"
}
}
)
