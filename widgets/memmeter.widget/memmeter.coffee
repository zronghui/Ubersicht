command: "memmeter.widget/ubermemmeter.rb"
refreshFrequency: 10000
render: (output) -> """
  <h1>RAM</h1>
  <pre>#{output}</pre>
"""
style: """
  border none
  box-sizing border-box
  color #141f33
  font-weight 300
  line-height 1.5
  padding 10px
  right 30px
  top 440px
  width 190px
  text-align justify
  background rgba(0,0,0,.25)
  border-radius 2px
  transition all .3s ease-in-out

  h1
    line-height 1
    margin 0 0 10px 0
    padding 5px
    font-size 16px
    color rgba(255,255,255,.5)
    text-align center
    background rgba(0,0,0,.35)
    border-radius 3px

  pre
    font-size 10px
    font-family Menlo
    line-height 1.45
    font-weight 300
    margin 0
    font-family MesloLGMDZ
    color rgba(255,255,255,.8)
  
  pre span
    font-size 10px
    font-family Menlo

  .red
    color rgba(221, 74, 74, 1)

  .cyan
    color rgba(73, 204, 217, 1)

  .yellow
    color rgba(202, 150, 68, 1)

  body.inverted &
    transition all .3s ease-in-out
    -webkit-filter invert(100%) contrast(120%)
    color black !important
"""
