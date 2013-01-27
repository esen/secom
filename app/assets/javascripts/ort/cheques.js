// Charles Lawrence - Feb 16, 2012. Free to use and modify. Please attribute back to @geuis if you find this useful
// Twitter Bootstrap Typeahead doesn't support remote data querying. This is an expected feature in the future. In the meantime, others have submitted patches to the core bootstrap component that allow it.
// The following will allow remote autocompletes *without* modifying any officially released core code.
// If others find ways to improve this, please share.

var keyup_function = function (ev, obj, url) {
    ev.stopPropagation();
    ev.preventDefault();

    //filter out up/down, tab, enter, and escape keys
    if ($.inArray(ev.keyCode, [40, 38, 9, 13, 27]) === -1) {

        //set typeahead source to empty
        obj.data('typeahead').source = [];

        //active used so we aren't triggering duplicate keyup events
        if (!obj.data('active') && obj.val().length > 0) {
            obj.data('active', true);

            //Do data request. Insert your own API logic here.
            $.getJSON(url, {
                q:obj.val()
            }, function (data) {
                console.log(data)


                //set this to true when your callback executes
                obj.data('active', true);

                //Filter out your own parameters. Populate them into an array, since this is what typeahead's source requires
                var arr = [],
                    i = data.length;
                while (i--) {
                    arr[i] = data[i]
                }

                //set your results into the typehead's source
                obj.data('typeahead').source = arr;

                //trigger keyup on the typeahead to make it search
                obj.trigger('keyup');

                //All done, set to false to prepare for the next remote query.
                obj.data('active', false);

            });

        }
    }
}

$('#ort_cheque_participant').typeahead().on('keyup', function (ev) {
    keyup_function(ev, $(this), "/ort/participants")
});

$('#ort_cheque_exam').typeahead().on('keyup', function (ev) {
    keyup_function(ev, $(this), "/ort/exams")
});