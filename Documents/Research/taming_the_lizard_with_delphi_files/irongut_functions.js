// irongut_functions.js
// JavaScript functions used on Irongut's Delphi Pages http://www.paranoia.clara.net
// Written by Dave Murray. Copyright (c) 2003 - 2004 Conspiracy Software

//  function open_window(strURL) - opens the specified URL in a new window
//  function addSidebar() - adds Pascal Newsletter sidebar to Mozilla / Netscape
//  function addMDSidebar() - adds Mozilla-Delphi Sidebar to Mozilla / Netscape
//  function VoteIDP() - vote for IDP link
//  function VoteNewsletter() - vote for the Pascal Newsletter link
//  function getCookie(name) - read a cookie, returns string or null
//  function setCookie(name, value, expires, path, domain, secure) -  writes a cookie


  function open_window(strURL){
  // opens a popup window
    if (navigator.appName=="Netscape") {
      var popup = window.open("", "_blank", "toolbar=1,location=1,directories=1,status=1,menubar=1,scrollbars=1,resizable=1");
    } else {
      var popup = window.open("", "_blank", "");
    }
    popup.location = strURL;
  }

  function addSidebar() { 
  // adds Sidebar to Mozilla / Netscape
    if ((typeof window.sidebar == "object") && (typeof window.sidebar.addPanel == "function"))
      window.sidebar.addPanel ("Pascal Newsletter", "http://www.paranoia.clara.net/sidebar/pn_sidebar.html","");
    else {
      var rv = window.confirm ("The Pascal Newsletter sidebar requires a Mozilla or Netscape 6+ browser. Would you like to upgrade now?"); 
      if (rv) 
        open_window("http://www.mozilla.org/products/mozilla1.x/");
      }
    }

function addMDSidebar() { 
// adds Mozilla-Delphi Sidebar to Mozilla / Netscape
  if ((typeof window.sidebar == "object") && (typeof window.sidebar.addPanel == "function"))
    window.sidebar.addPanel ("Mozilla-Delphi", "http://delphi.mozdev.org/sidebar/mozilla_delphi_sidebar.html",""); 
  else {
    var rv = window.confirm ("The Mozilla-Delphi Project sidebar requires a Mozilla or Netscape 6+ browser. Would you like to upgrade now?");
    if (rv) 
      open_window("http://www.mozilla.org/products/mozilla1.x/");
    }
  } 

  function VoteIDP(){
  // opens vote for IDP windows
    open_window("http://top100borland.com/in.php?who=450");
    open_window("http://top200.jazarsoft.com/delphi/popup.php3?id=irongut");
    open_window("http://news.optimax.com/delphi/links/links.exe/click?id=8DB24C6E0035");
// SITE SUSPENDED!    open_window("http://www.sandbrooksoftware.com/cgi-bin/TopSite2/rankem.cgi?id=irongut");
    open_window("http://www.programmingpages.com/?r=paranoiaclaranet");
  }

  function VoteNewsletter(){
  // opens vote for Pascal Newsletter windows
// SITE SUSPENDED!    open_window("http://www.sandbrooksoftware.com/cgi-bin/TopSite2/rankem.cgi?id=latium");
    open_window("http://news.optimax.com/delphi/links/links.exe/click?id=70C517ECAE6E");
    open_window("http://top200.jazarsoft.com/delphi/rank.php3?id=latium");
    open_window("http://top100borland.com/in.php?who=20");
    open_window("http://www.programmingpages.com/?r=latiumsoftwarecomenpascal");
  }

  function getCookie(name) {
  // read a cookie, returns string or null if cookie does not exist
    var dc = document.cookie;
    var prefix = name + "=";
    var begin = dc.indexOf("; " + prefix);
    if (begin == -1) {
      begin = dc.indexOf(prefix);
      if (begin != 0) return null;
      }
    else
      begin += 2;
    var end = document.cookie.indexOf(";", begin);
    if (end == -1)
      end = dc.length;
    return unescape(dc.substring(begin + prefix.length, end));
  }

  function setCookie(name, value, expires, path, domain, secure) {
  // writes a cookie
    var curCookie = name + "=" + escape(value) +
      ((expires) ? "; expires=" + expires : "") +
      ((path) ? "; path=" + path : "") +
      ((domain) ? "; domain=" + domain : "") +
      ((secure) ? "; secure" : "");
    document.cookie = curCookie;
  }


