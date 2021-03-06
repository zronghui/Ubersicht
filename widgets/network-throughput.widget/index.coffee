command: """
    network-throughput.widget/lib/network.sh
"""
refreshFrequency: 2000

style: """
    // Change bar height
    bar-height = 6px

    // Align contents left or right
    widget-align = left

    // Position this where you want
    bottom 0px
    right 100px

    // Statistics text settings
    color #fff
    font-family Helvetica Neue
    background rgba(#000, .5)
    padding 10px 10px 15px
    border-radius 5px

    .container
        width: 130px
        text-align: widget-align
        position: relative
        clear: both

    .widget-title
        text-align: widget-align

    .stats-container
        width: 100%
        margin-bottom 5px
        border-collapse collapse

    td
        font-size: 10px
        font-weight: 300
        color: rgba(#fff, .9)
        text-shadow: 0 1px 0px rgba(#000, .7)
        text-align: widget-align

    .widget-title
        font-size 10px
        text-transform uppercase
        font-weight bold

    .stat
        width: 50%
        .down
            font-size 15px
            float: left
            text-align left
        .up
            font-size 15px
            float: right
            text-align right

    .bar-container
        width: 100%
        height: bar-height
        border-radius: bar-height
        clear: both
        background: rgba(#fff, .5)
        position: absolute
        margin-bottom: 5px

    .bar
        height: bar-height
        transition: width .2s ease-in-out

    .bar:first-child
        border-radius: bar-height 0 0 bar-height
        float: left

    .bar:last-child
        border-radius: 0 bar-height bar-height 0
        float: right

    .bar-down
        background: rgba(#c00, .5)

    .bar-up
        background: rgba(#0bf, .5)
"""

render: -> """
    <div class="container">
        <!-- <div class="widget-title">Network</div> -->
        <table class="stats-container">
            <tr>
                <td class="stat"><span class="down"></span></td>
                <td class="stat"><span class="up"></span></td>
            </tr>
        </table>
        <div class="bar-container">
            <div class="bar bar-down"></div>
            <div class="bar bar-up"></div>
        </div>
    </div>
"""

update: (output, domEl) ->

    usage = (bytes) ->
        kb = bytes / 1024
        usageFormat kb

    usageFormat = (kb) ->
        if kb > 1024
            mb = kb / 1024
            "#{parseFloat(mb.toFixed(1))} m/s"
        else
            "#{parseFloat(kb.toFixed(0))} k/s"

    updateStat = (sel, currBytes, totalBytes) ->
        percent = (currBytes / totalBytes * 100).toFixed(1) + "%"
        if sel=='down'
          $(domEl).find(".#{sel}").text usage(currBytes) + '↓'
        else if sel=='up'
          $(domEl).find(".#{sel}").text usage(currBytes) + '↑'
        $(domEl).find(".bar-#{sel}").css "width", percent

    args = output.split "^"

    downBytes = (Number) args[0]
    upBytes = (Number) args[1]

    totalBytes = downBytes + upBytes

    updateStat 'down', downBytes, totalBytes
    updateStat 'up', upBytes, totalBytes
