$(document).ready(function(){

  $(".blogbutton").click(function(){
    $(".posts-follows").css("display", "flex");
    $(".followers").css("display", "none");
    $(".following").css("display", "none");
  });

  $(".followerbutton").click(function(){
    $(".followers").css("display", "flex");
    $(".posts-follows").css("display", "none");
    $(".following").css("display", "none");
  });

  $(".followingbutton").click(function(){
    $(".following").css("display", "flex");
    $(".posts-follows").css("display", "none");
    $(".followers").css("display", "none");
  });

});

function confirmDelete() {
  if (window.confirm("Are you sure you want to delete your profile? There is no retreival")){
      window.open("http://localhost:9393/del")
  };
};

function countChar(x) {
  var length = x.value.length;
  if (length > 150){
    $("#blog-submit").prop('type', 'button');
    $("#blog-submit").css('color', 'grey');
    $("#charNum").css('color', 'red');
  } else {
    $("#blog-submit").prop('type', 'submit');
    $("#blog-submit").css('color', 'navy');
    $("#charNum").css('color', 'green');
  };
  $("#charNum").text(150 - length);
};
