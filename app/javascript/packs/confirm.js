$(document).ready(function(){
  $('#confirm').on('click', function(){
    ans= confirm("are you sure you want to delete user")
    if(ans==true)
    {
    console.log("true");
    }
    else
    {
    console.log("f")
    }
  });
})
