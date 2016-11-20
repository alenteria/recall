(function() {

  var firePixel = function (pixelIds) {
    if(pixelIds === '') {
      return;
    }

    var dxDomain = '//tags.w55c.net/rs?id=';
    var pixels = pixelIds.split(',');

    for (var i = 0; i < pixels.length; i++) {
      var dxPixelId = pixels[i];
      var cb = Math.floor(Math.random() * 99999);
      var pixelSrc = dxDomain + dxPixelId + '&rnd=' + cb;
      var img = document.createElement('img');
      img.src = pixelSrc;
    }
  };

  var normalizeUrl = function (normURL) {
    var replacedURL = normURL.replace(/^https?:\/\//, '');

    if (replacedURL.substr(-1) == '/') {
      replacedURL = replacedURL.substr(0, replacedURL.length - 1);
    }

    return replacedURL;
  };

  /* Main function to fire pixel based on matching the current URL to the URL Map */
  var dxUpx = function () {
    // This represents a list of pixel ids to fire.  The default is the diagnostic pixel.
    var dxPixelIds = 'c910ea2ce4d94bbc856cc995afa73e49';
    var normalizedUrl = normalizeUrl(window.location.href);

    if (urlMap.hasOwnProperty(normalizedUrl)) {
      // If we find a match, replace the diagnostic pixel with those associated with the URL.
      dxPixelIds = urlMap[normalizedUrl];
    }

    firePixel(dxPixelIds);
  };

  var urlMap = {
    "pldthome.com/fibr":"7e9ef18db0df4388bff685c2669d34a8",
    "pldthome.com/fibr/vas":"9ce91fc5b3904306ba473786df84cc94",
    "pldthome.com/fibr/testimonials":"7b833062dc6b4238a857a3bc4094f31f",
    "pldthome.com/fibr/events":"7193d081285e47b085a442b0f29574dc",
    "pldthome.com/fibr/support":"1baecf39a9ec401195648fd0878303e6",
    "pldthome.com/fibr/areas":"14d066b9a05b44a79aeb3e45129884fc",
    "shop.pldthome.com/Home/AreaCoverage?planId=1569":"c7de7fc51fce42078ec512b05341892b",
    "shop.pldthome.com/Home/SelectAddedService":"c045deca80604c49a63693b8e9ad95dc",
    "shop.pldthome.com/Residential":"734c8a4103e84cdcbe6266535e736cdc",
    "shop.pldthome.com/Residential/Success":"7bf5c630c54e461d82778b34394049ed",
    "shop.pldthome.com/Home/AreaCoverage?planId=1636":"417ac44564104ef4b1d3479cd30b1941",
    "shop.pldthome.com/Home/SelectAddedService":"9af592e8bfe34e13b08c7057b74b8ab0",
    "shop.pldthome.com/Residential":"30de201252404e6aa39895397982a514",
    "shop.pldthome.com/Residential/Success":"8f71f237877e4b4ebf20b7748626eee7",
    "pldthome.com/fibr/power-plus-3500-cignal-reservation":"e299bdfd2eaa42d3b1c14c091a75093f",
    "pldthome.com/fibr/power-plus-3500-cignal-reservation/success":"39730239e48b4f4386a4cdf32affdd72",
    "pldthome.com/fibr/gigaplan-reservation":"c33136ceac3848b4a4502ceed59b98cc",
    "pldthome.com/fibr/gigaplan-reservation/success":"2466ca20e1fb4294a529fd0db29235d2",
    "pldthome.com/fibr/power-plus-3500-smart-mobile-plan-with-iphone-6s-reservation-subscriber":"5d82eaa4aad640b7935440621b411820",
    "pldthome.com/fibr/testimonials/james-deakin":"3a4c7fac539844a6a0cd065d16e1fe57",
    "pldthome.com/fibr/testimonials/ramon-orlina":"2ce216b23c354d90be0fc40642ce6596",
    "pldthome.com/fibr/testimonials/michael-cacnio":"a90500b53a96427b86c4165178eb1acc",
    "pldthome.com/fibr/testimonials/ryan-cayabyab":"27b1ac2034824cea817c1de4bfa0957a",
    "pldthome.com/fibr/testimonials/tweetie-de-leon":"369174ff27d24dba849aadbd8f0ed0fe",
    "pldthome.com/fibr/testimonials/rob-chien":"a2379c323e464791815dde9bb3441535",
    "pldthome.com/fibr/testimonials/patricia-hizon":"8bbf2afda3fd4c7fa84ce2ad4e4bc2d6"
  };

  dxUpx();

})();
