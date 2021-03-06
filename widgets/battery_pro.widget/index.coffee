#-----------------------------------------------------------------------#
#																		#
# Battery Pro for Übersicht 											#
# 																		#
# Created July 2018 by Mike Pennella (github.com/mpen01/battery_pro)	#
#																		#
# THEME & STYLE OPTIONS													#
# Change the variables below to change the appearance of the widget		#
theme		= 'color'	# mono, paper, color or dark (default is color)	#
style		= 'full'	# mini or full	(default is full)				#
#																		#
# LOW POWER THRESHHOLD													#
# Battery indicators turn red if battery is discharging and				#
# below this number.  Default is 20%, you may want it higher or lower	#
lowPower	= 20														#
#																		#
# POSITION WIDGET ON SCREEN												#
pos_bottom		= '0px'													#
pos_right	= '0px'													#
#																		#
#-----------------------------------------------------------------------#

labelColor			='WHITE'
opacityLevel		='1'

if theme == 'mono' || theme == 'dark'
  statusColor		= 'WHITE'
  chargingColor		= 'WHITE'
  dischargeColor	= 'WHITE'
  lowPowerColor		= 'WHITE'
  lineColor			= 'WHITE'
  bkground			= 'rgba(#000, 0.0)'
  fullCharge		= "battery_pro.widget/icons/white_full_charge.png"
  almostFullCharge	= "battery_pro.widget/icons/white_almost_charged.png"
  halfCharged		= "battery_pro.widget/icons/white_half_charged.png"
  lowCharge			= "battery_pro.widget/icons/low-battery.png"
  batteryCharging	= "battery_pro.widget/icons/white_charging.png"
  batteryCharged	= "battery_pro.widget/icons/white_full_charge.png"
  
else if theme == 'paper'
  statusColor		= 'BLACK'
  chargingColor		= 'BLACK'
  dischargeColor	= 'BLACK'
  lowPowerColor		= 'BLACK'
  lineColor			= 'WHITE'
  bkground			= 'rgba(#fff, 1)'
  fullCharge		= "battery_pro.widget/icons/black_full_charge.png"
  almostFullCharge	= "battery_pro.widget/icons/black_almost_charged.png"
  halfCharged		= "battery_pro.widget/icons/black_half_charged.png"
  lowCharge			= "battery_pro.widget/icons/low-battery.png"
  batteryCharging	= "battery_pro.widget/icons/black_charging.png"
  batteryCharged	= "battery_pro.widget/icons/black_full_charge.png"
  
else
  statusColor		= '#D3D3D3'   # Grey
  chargingColor		= '#7dff7d'   # Bright Green
  dischargeColor	= 'WHITE'
  lowPowerColor		= '#FF0000'   # Red
  lineColor			= '#00BFFF'	  # Blue
  bkground			= 'rgba(#000, 0.5)'
  fullCharge		= "battery_pro.widget/icons/full_charge.png"
  almostFullCharge	= "battery_pro.widget/icons/almost_charged.png"
  halfCharged		= "battery_pro.widget/icons/half_charged.png"
  lowCharge			= "battery_pro.widget/icons/low-battery.png"
  batteryCharging	= "battery_pro.widget/icons/white_charging.png"
  batteryCharged	= "battery_pro.widget/icons/blue_charged.png"
  
if theme == 'dark'
   bkground			= 'rgba(#000000)'
   lineColor		= 'rgba(#000000, 0.8)'
   opacityLevel		= '0.6'
   
if style == 'mini'
   labelColor		= 'rgba(#000, 0.0)' 
   statusColor		= 'rgba(#000, 0.0)'  
   lineColor		= 'rgba(#000, 0.0)' 
   bkground			= 'rgba(#000, 0.0)'

command: "pmset -g batt | grep -o '[0-9]*%; [a-z]*'"

# Refresh the widget every 10 seconds
refreshFrequency: 10000

style: """
  bottom: #{pos_bottom}
  right:	 #{pos_right}
  font-family: Avenir Next

  div
    display: block
    border: 1px solid #{lineColor}
    border-radius 5px
    text-shadow: 0 0 1px #{bkground}
    background: #{bkground}
    font-size: 16px
    font-weight: 400
    opacity: #{opacityLevel}
    padding: 4px 8px 4px 6px

  
  .percent
    font-size: 18px
    font-weight: 500
    margin: 0
    
  img
    height: 20px
    width: 20px
    margin-bottom: -3px
	
  .status
    padding: 0
    margin: 0
    margin-top: -2px
    margin-left: 5px
    font-size: 12px
    font-weight: 400
    max-width: 100%
    color: #{statusColor}
    text-overflow: ellipsis
    text-shadow: none

"""


render: -> """
  <div><img id="batt_icon" src=fullCharge>
  <a class='percent'></a><p class='status'></p></div>
"""

update: (output, domEl) ->
  values 	= output.split(";")
  percent 	= values[0]
  status 	= values[1].trim()
  div     	= $(domEl)
 
  if status == "discharging" && +(percent.substring(0, percent.length - 1)) <= lowPower
    div.find('.percent').html(percent.fontcolor(lowPowerColor)) 
    status = 'plug in soon'
    document.getElementById("batt_icon").src=lowCharge
  
  else if status == "discharging"
    div.find('.percent').html(percent.fontcolor(dischargeColor)) 
    if +(percent.substring(0, percent.length - 1)) >= 90
      document.getElementById("batt_icon").src=fullCharge
    else if +(percent.substring(0, percent.length - 1)) > 60
      document.getElementById("batt_icon").src=almostFullCharge
    else if +(percent.substring(0, percent.length - 1)) > 20
      document.getElementById("batt_icon").src=halfCharged
  
  else if status == "charging"  || status == "finishing"
    document.getElementById("batt_icon").src=batteryCharging
    div.find('.percent').html(percent.fontcolor(chargingColor)) 
  
  else if status == "charged"
    document.getElementById("batt_icon").src=batteryCharged
    div.find('.percent').html(percent.fontcolor(chargingColor))
    
  else
    div.find('.percent').html(percent.fontcolor(chargingColor))
    document.getElementById("batt_icon").src=batteryCharging
    status = 'AC attached'
    
  if status=="charged"
    status = "已充满"
  else if status=="discharging"
    status = "放电中"
  else if status=="charging"
    status = "充电中"
  div.find('.status').html(status)
  
  

