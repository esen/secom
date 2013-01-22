# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$("#ort_exam_start_date").datepicker({"format": "yyyy-mm-dd"})

$("#set_cost").change ->
  if $("#set_cost").is(":checked")
    $("#cost_div").show()
  else
    $("#cost_div").hide()
