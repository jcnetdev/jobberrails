$j(document).ready(function() {
    $j("div.categoryHandle").mousedown(function() {
        $j(this).fadeTo(500, 0.4).addClass('draggingItem').get(0);
    });
    $j("div.categoryHandle").mouseup(function() {
        $j(this).fadeTo(500,1).removeClass('draggingItem');
    });
});

function showOverlay(element) {
    var el = document.getElementById('overlay');
    var elTo = document.getElementById(element);
    if (!elTo) {
        return;
    }
    var sz = elTo.positionedOffset(elTo);
    
    if (element != "categoriesContainer") {
        var tt = document.getElementById("categoriesContainer").positionedOffset(elTo);    
        el.style.top = tt.top + sz.top + 'px';
        el.style.left = tt.left + sz.left + 'px';
    } else {
        el.style.top = sz.top + 'px';
        el.style.left = sz.left + 'px';
    }
    el.style.width = elTo.offsetWidth + 'px';
    el.style.height = elTo.offsetHeight + 'px';
    el.style.display = 'block';
}