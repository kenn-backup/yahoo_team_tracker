$(document).ready(function() {

  $('#login').on('submit', function(event){
    event.preventDefault();

    var $target = $(event.target)

    $.ajax({
      type: $target.attr('method'),
      url: $target.attr('action'),
      data: $target.serialize(),
      dataType: 'json',
      success: function(response){
        console.log("success")
        window.location.replace(response.path)
      },
      error: function(){
        console.log("fail")
        errorMod.show("Authentication Failed")
      }
    })
  })

  $('.add_player').on('click', function(){
    $.ajax({
      type: "get",
      url: "/teams/new/add_player",
      data: { player_count: $('.player').length },
      success: function(response){
        $('.player_selection').append(response);
      },
      error: function(){
        console.log("add_player ajax call failed")
      }
    })
  })

  $('.remove_player').on('click', function(){
    if ($('.player_selection li').length <= 1){
      $('.player_selection li:last-child').remove()
      $('.initiallyHidden').toggle(false)
    }
    else {
      $('.player_selection li:last-child').remove()
    }
    })

  $('.add_buttons').on('click', function(){
    $('.initiallyHidden').toggle(true)
  })

  $('.release_player').on('click', function(event){
    event.preventDefault()

    $target = $(event.target)

    $.ajax({
      type: 'delete',
      url: $target.attr('href'),
      dataType: 'json',
      data: {player_id: $target.attr('name')},
      success: function(){
        $target.parent().parent().remove()
      },
      error: function(){
        console.log("removing players from team with ajax isn't working")
      }
    })
  })

  $('.vote').on('click', function(event){
    event.preventDefault()

    $target = $(event.target)

    $.ajax({
      type: 'put',
      url: $target.attr('href'),
      dataType: 'json',
      success: function(response){
        $("#team_" + response.team_id).html(response.score)
      },
      error: function(response){
        window.location.replace('/login')
      }
    })
  })

  $('#add_to_team').on('submit', function(event){
    event.preventDefault()

    var $target = $(event.target)

    $.ajax({
      type: 'put',
      url: $target.attr('action'),
      data: {player_id: $target.find(":selected").val()},
      dataType: 'json',
      success: function(player){
        $('.my_team').append('<tr><td>' + player.player_name + '</td><td>' + player.position + '</td><td>' + player.pro_team + '</td><td>' + player.age + '</td><td><a class="release_player button" href="/teams/' + player.team + '/delete_player" name="' + player.id + '">Release</a></td></tr>');
      },
      error: function(){
        console.log("adding players to team ajax call is not working")
      }
    })
  })


});
