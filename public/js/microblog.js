$(document).ready(function(){
  $("#logout").click(function(){
    $("#logout").hide();
    $("signin").show();
    $("signup").show();
  });

  $("#signin").click(function(){
    $("#signin").hide();
    $("#signup").hide();
    $("#logout").show();
  });

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
}

}
