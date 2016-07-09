// irongut_ads2_sub.js v2.0
// JavaScript for Adverts on pages in sub-dirs, IDP http://www.paranoia.clara.net/
// v2.0 Stores html in arrays so each banner is fully customisable as html, not just images
// v2.1 Updated for css
// v2.2 Bug fixes for sequencing of ads
// Written by Dave Murray. Copyright (c) 2003 - 2006 Conspiracy Software

//  function getVBanner()  - displays vertical advert banner
//  function getHBanner()  - displays horizontal advert banner
//  function incAdCookie() - increases cookie without displaying an ad

//  getHBanner increases cookie so call getVBanner first.
//  Any page that doesn't call getHBanner must call incAdCookie


  // setup banner vars
  NO_OF_BANNERS = 12;
  var Banner_No = 0;
  var H_Banner = new Array(NO_OF_BANNERS);
  var V_Banner = new Array(NO_OF_BANNERS);


  // setup horizontal banner html
  H_Banner[0] = '<a href="http://www.eve-online.com/"><img src="../img/eve_elite_on_steroids468x60.png" name="H_Banner" alt="EVE Online" title="EVE Online: Elite On Steroids"></a><br>'; // EVE Online: Elite On Steroids
  H_Banner[1] = '<a href="http://www.paranoia.clara.net/software/wallswap.html"><img src="../img/wallswap_banner_468x60.png" name="H_Banner" alt="WallSwap" title="Download WallSwap FREE"></a><br>'; // WallSwap Banner
  H_Banner[2] = '<iframe width="468" height="82" scrolling="no" frameborder=0 src="http://rcm-uk.amazon.co.uk/e/cm?t=irongutsdelph-21&l=bn1&browse=269818&mode=books-uk&p=13&o=2&f=ifr&amp;lt1=_blank"> <table border="0" cellpadding="0" cellspacing="0" width="468" height="82"><tr><td><A HREF="http://www.amazon.co.uk/exec/obidos/redirect-home/irongutsdelph-21" target=_blank><img src="http://images-eu.amazon.com/images/G/02/associates/recommends/default_468x82.gif" width=468 height=82 border="0" access=regular></a></td></tr></table></iframe>'; // Amazon: UML Books Browse-based Bestsellers IFRAME
  H_Banner[3] = '<a href="http://www.installaware.com/landingea.html"><img src="../img/installaware_468x60.png" name="H_Banner" alt="InstallAWARE" title="InstallAWARE - Use Windows Installer without rocket science!"></a><br>'; // InstallAWARE Banner
  H_Banner[4] = '<a href="http://free.hostdepartment.com/o/owenmooney/"><img src="../img/kbvortex_468x60.png" name="H_Banner" alt="KnowledgeBASE Vortex" title="KnowledgeBASE Vortex - Software for IT Pros"></a><br>'; // KnowledgeBASE Vortex
  H_Banner[5] = '<a href="http://www.spreadfirefox.com/?q=affiliates&id=6789&t=58"><img src="../img/firefox_rediscover_468x60.png" name="H_Banner" alt="Firefox Browser" style="border: 0px solid ; width: 468px; height: 60px;" title="Firefox: Rediscover the Web"></a><br>'; // Firefox: Rediscover the Web Banner
  H_Banner[6] = '<iframe width="468" height="82" scrolling="no" frameborder="0" src="http://rcm-uk.amazon.co.uk/e/cm?t=irongutsdelph-21&l=st1&search=kylix&mode=books-uk&p=13&o=2&f=ifr&amp;lt1=_blank"> <table border="0" cellpadding="0" cellspacing="0" width="468" height="82"><tr><td><A HREF="http://www.amazon.co.uk/exec/obidos/redirect-home/irongutsdelph-21"><img src="http://images-eu.amazon.com/images/G/02/associates/recommends/default_468x82.gif" width="468" height="82" border="0" access="regular"></a></td></tr></table></iframe>'; // Amazon: Kylix Books Keyword IFRAME
  H_Banner[7] = '<a href="http://www.eve-online.com/"><img src="../img/eve_forget_freelancer468x60.png" name="H_Banner" alt="EVE Online" title="EVE Online Is The New Elite"></a><br>'; // EVE Online Is The New Elite
  H_Banner[8] = '<a href="http://www.paranoia.clara.net/delphi_newsletter.html"><img src="../img/pascal-en-468x60.gif" name="H_Banner" alt="Pascal Newsletter" style="border: 0px solid ; width: 468px; height: 60px;" title="Subscribe to the Pascal Newsletter"></a><br>'; // Pascal Nesletter Banner
  H_Banner[9] = '<a href="http://www.freewarefiles.com/"><img src="../img/freewarefiles468x60.png" name="H_Banner" alt="Freeware Files" title="Freeware Files"></a><br>'; // Freeware Files Banner
  H_Banner[10] = '<a href="http://www.filetransit.com/"><img src="../img/filetransit_logo468x60.png" name="H_Banner" alt="File Transit" title="The File Transit - Shareware Resource"></a><br>'; // File Transit Banner


  // setup vertical banner html
  V_Banner[0] = '<iframe width="120" height="476" scrolling="no" frameborder="0" src="http://rcm-uk.amazon.co.uk/e/cm?t=irongutsdelph-21&l=st1&search=borland&mode=software-uk&p=10&o=2&f=ifr&amp;lt1=_blank"> <table border="0" cellpadding="0" cellspacing="0" width="120" height="476"><tr><td><A HREF="http://www.amazon.co.uk/exec/obidos/redirect-home/irongutsdelph-21"><img src="http://images-eu.amazon.com/images/G/02/associates/recommends/default_120x476.gif" width="120" height="476" border="0" access="regular"></a></td></tr></table></iframe><br><br>'; // Amazon: Borland Software
  V_Banner[1] = '<a href="http://www.paranoia.clara.net/delphi_newsletter.html"><img src="../img/pascal-en-125x125.gif" name="V_Banner" alt="Pascal Newsletter" style="border: 0px solid ; width: 125px; height: 125px;" title="Subscribe to the Pascal Newsletter"></a><br><br>'; // Pascal Nesletter
  V_Banner[2] = '<a href="http://www.eve-online.com/"><img src="../img/eve120x240.png" name="V_Banner" alt="EVE Online" title="EVE Online"></a><br>'; // EVE Online
  V_Banner[3] = '<a href="http://www.freewarefiles.com/"><img src="../img/freewarefiles_110x85.png" name="V_Banner" alt="Freeware Files" title="Freeware Files" style="border: 0px solid ; width: 110px; height: 85px;"></a><br><br>'; // Freeware Files
  V_Banner[4] = '<a href="http://www.winsite.com/"><img src="../img/winsite_170x110.png" name="V_Banner" alt="Winsite" style="border: 0px solid ; width: 170px; height: 110px;" title="Winsite Archive"></a><br><br>'; // Winsite Archive
  V_Banner[5] = '<iframe width="120" height="476" scrolling="no" frameborder="0" src="http://rcm-uk.amazon.co.uk/e/cm?t=irongutsdelph-21&l=st1&search=delphi&mode=books-uk&p=10&o=2&f=ifr&amp;lt1=_blank"> <table border="0" cellpadding="0" cellspacing="0" width="120" height="476"><tr><td><A HREF="http://www.amazon.co.uk/exec/obidos/redirect-home/irongutsdelph-21"><img src="http://images-eu.amazon.com/images/G/02/associates/recommends/default_120x476.gif" width="120" height="476" border="0" access="regular"></a></td></tr></table></iframe><br><br>'; // Amazon: Delphi Books
  V_Banner[6] = '<a href="http://www.paranoia.clara.net/software/wallswap.html"><img src="../img/wallswap_banner_164x210.png" name="V_Banner" alt="WallSwap" style="border: 0px solid ; width: 164px; height: 210px;" title="Download WallSwap FREE"></a><br><br>'; // WallSwap
  V_Banner[7] = '<a href="http://www.filetransit.com/"><img src="../img/filetransit_logo152x136.png" name="V_Banner" alt="File Transit" title="The File Transit - Shareware Resource" style="border: 0px solid ; width: 152px; height: 136px;"></a><br><br>'; // File Transit
  V_Banner[8] = '<a href="http://www.amazon.co.uk/exec/obidos/redirect?tag=irongutsdelph-21&path=tg/browse/-/916502/qid%3D1067119899/sr%3D6-1"><img src="../img/amazon_dotnet_120x60.gif" name="V_Banner1" alt="Amazon: .Net" style="border: 0px solid ; width: 120px; height: 60px;" title="Buy books and software for developing with .Net at Amazon.co.uk"></a><br><br><br><a href="http://www.amazon.co.uk/exec/obidos/redirect?tag=irongutsdelph-21&path=tg/browse/-/1035202"><img src="../img/amazon_starwars_120x60.gif" name="V_Banner2" alt="Amazon: Star Wars" style="border: 0px solid ; width: 120px; height: 60px;" title="Buy Star Wars books and games at Amazon.co.uk"></a><br><br><br><a href="http://www.amazon.co.uk/exec/obidos/redirect-home?tag=irongutsdelph-21&site=amazon&site=videogames"><img src="../img/amazon_videogames1_144x70.gif" name="V_Banner3" alt="Amazon: Video Games" style="border: 0px solid ; width: 144px; height: 70px;" title="Buy video games at Amazon.co.uk"></a><br><br>'; // Amazon: .Net, etc
  V_Banner[9] = '<a href="http://www.eve-online.com/"><img src="../img/eve_anim120x600.gif" name="V_Banner" alt="EVE Online" title="EVE Online"></a><br>'; // EVE Online Animated
  V_Banner[10] = '<a href="http://www.spreadfirefox.com/?q=affiliates&id=6789&t=58"><img src="../img/firefox_rediscover_120x240.png" name="V_Banner" alt="Firefox Browser" style="border: 0px solid ; width: 120px; height: 240px;" title="Firefox: Rediscover the Web"></a><br><br>'; // Firefox: Rediscover



  function getVBanner() {
  // displays vertical advert banner
    // cookie operations
    if (getCookie("IDPbanner") == null)
      // write new cookie if none present
      setCookie("IDPbanner", 0, 0, "/");
    // read cookie for banner no
    Banner_No = parseInt(getCookie("IDPbanner"));
    if ((Banner_No == NO_OF_BANNERS) || (Banner_No > NO_OF_BANNERS))
      // reset if no of banners exceeded
      Banner_No = 0;
    // display banner
    document.writeln(V_Banner[Banner_No]);
    }

  function getHBanner() {
  // displays horizontal advert banner
    // cookie operations
    if (getCookie("IDPbanner") == null)
      // write new cookie if none present
      setCookie("IDPbanner", 0, 0, "/");
    // read cookie for banner no
    Banner_No = parseInt(getCookie("IDPbanner"));
    if ((Banner_No == NO_OF_BANNERS) || (Banner_No > NO_OF_BANNERS))
      // reset if no of banners exceeded
      Banner_No = 0;
    // display banner
    document.writeln(H_Banner[Banner_No]);
    // store cookie for next banner
    Banner_No ++;
    setCookie("IDPbanner", Banner_No, 0, "/");
    }

  function incAdCookie() {
  // increases cookie without displaying ad, use on pages with no getHBanner
    // ensure cookie exists
    if (getCookie("IDPbanner") == null)
      // write new cookie if none present
      setCookie("IDPbanner", 0, 0, "/");
    // read cookie for banner no
    Banner_No = parseInt(getCookie("IDPbanner"));
    if ((Banner_No == NO_OF_BANNERS) || (Banner_No > NO_OF_BANNERS))
      // reset if no of banners exceeded
      Banner_No = 0;
    // store cookie for next banner
    Banner_No ++;
    setCookie("IDPbanner", Banner_No, 0, "/");
    }


