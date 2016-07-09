// irongut_menu.js
// JavaScript used in menu on Irongut's Delphi Pages http://www.paranoia.clara.net
// Written by Dave Murray. Copyright (c) 2003 Conspiracy Software

//  function NormalImage(pic) - changes image pic to normal menu image
//  function HotImage(pic) - changes image pic to highlighted menu image
//  function SubNormalImage(pic) - shows normal menu image for pages in sub dirs
//  function SubHotImage(pic) - shows highlighted menu image for pages in sub dirs


  function NormalImage(pic) {
  // shows normal menu image
    pic.src = "img/next.png";
  }

  function HotImage(pic) {
  // shows highlighted menu image
    pic.src = "img/next_hot.png";
  }

  function SubNormalImage(pic) {
  // shows normal menu image for pages in sub dirs
    pic.src = "../img/next.png";
  }

  function SubHotImage(pic) {
  // shows highlighted menu image for pages in sub dirs
    pic.src = "../img/next_hot.png";
  }


