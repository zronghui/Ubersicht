#-----------------------------------------------------------------------#
# CPU temp for Übersicht 											#
#-----------------------------------------------------------------------#

pos_bottom		= '0px'
pos_right	= '260px'

opacityLevel		='1'
lineColor			= '#00BFFF'	  # Blue
bkground			= 'rgba(#000, 0.5)'

command: "/usr/local/lib/ruby/gems/2.6.0/bin/iStats cpu | tr -s ' ' |cut -d ' ' -f 3- | cut -d 'C' -f 1"
refreshFrequency: 5000

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

  
  .cpu_temp
    font-size: 18px
    font-weight: 500
    margin: 0
  
  .status
      padding: 0
      margin: 0
      margin-top: -2px
      margin-left: 0px
      font-size: 12px
      font-weight: 400
      max-width: 100%
      color: #D3D3D3
      text-overflow: ellipsis
      text-shadow: none
"""


render: -> """
  <div>
    <a class='cpu_temp'></a>
    <p class='status'></p>
  </div>
"""

update: (output, domEl) ->
  values 	= output.split(".")
  cpu_temp 	= values[0]
  div     	= $(domEl)

  softLimeGreen = '#74fc55'
  lightYellow = '#ffed54'
  lightOrange = '#ffc154'
  lightRed = '#ff6254'

  if cpu_temp<=45
    cpuColor = softLimeGreen
  else if cpu_temp<=50
    cpuColor = lightYellow
  else if cpu_temp<=55
    cpuColor = lightOrange
  else
    cpuColor = lightRed
  div.find('.cpu_temp').html((cpu_temp+'°C').fontcolor(cpuColor))
  div.find('.status').html('CPU 温度')
