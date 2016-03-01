// $(document).ready(function(){
//   $("#logout").click(function(){
//     $("#logout").hide();
//     $("signin").show();
//     $("signup").show();
//   });
//
//   $("#signin").click(function(){
//     $("#signin").hide();
//     $("#signup").hide();
//     $("#logout").show();
//   });
// });

function confirmDelete() {
if (window.confirm("Are you sure you want to delete your profile? There is no retreival")){
    window.open("http://localhost:9393/del")
}

}
