showAnotherPage=()=>{
    $(".dynamic_container").addClass('animate__zoomOut')
    setTimeout(()=>{
       $(".dynamic_container").removeClass('animate__zoomOut') 
        $(".dynamic_container").addClass('animate__zoomIn')
        $(".dynamic_container").addClass('d-none')
    },1000)
    // $(".welcome_note_container").addClass('d-none')
}