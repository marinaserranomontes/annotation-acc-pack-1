/* global OT OTSolution OTKAnalytics ScreenSharingAccPack define */
(function () {
  /** Include external dependencies */
  var _;
  var $;
  var OTKAnalytics;

  if (typeof module === 'object' && typeof module.exports === 'object') {
    /* eslint-disable import/no-unresolved */
    _ = require('underscore');
    $ = require('jquery');
    OTKAnalytics = require('opentok-solutions-logging');
    /* eslint-enable import/no-unresolved */
  } else {
    _ = this._;
    $ = this.$;
    OTKAnalytics = this.OTKAnalytics;
  }

  /** Private variables */
  var _this;
  var _accPack;
  var _session;
  var _canvas;
  var _elements = {};

  /** Analytics */
  var _otkanalytics;

  // vars for the analytics logs. Internal use
  var _logEventData = {
    clientVersion: 'js-vsol-1.0.0',
    componentId: 'annotationsAccPack',
    name: 'guidAnnotationsKit',
    actionInitialize: 'Init',
    actionStart: 'Start',
    actionEnd: 'End',
    actionFreeHand: 'FreeHand',
    actionPickerColor: 'PickerColor',
    actionText: 'Text',
    actionScreenCapture: 'ScreenCapture',
    actionErase: 'Erase',
    actionUseToolbar: 'UseToolbar',
    variationAttempt: 'Attempt',
    variationError: 'Failure',
    variationSuccess: 'Success',
  };

  var _logAnalytics = function () {
    // init the analytics logs
    var _source = window.location.href;

    var otkanalyticsData = {
      clientVersion: _logEventData.clientVersion,
      source: _source,
      componentId: _logEventData.componentId,
      name: _logEventData.name
    };

    _otkanalytics = new OTKAnalytics(otkanalyticsData);

    var sessionInfo = {
      sessionId: _session.id,
      connectionId: _session.connection.connectionId,
      partnerId: _session.apiKey
    };

    _otkanalytics.addSessionInfo(sessionInfo);
  };

  var _log = function (action, variation) {
    var data = {
      action: action,
      variation: variation
    };
    _otkanalytics.logEvent(data);
  };

  /** End Analytics */

  // Trigger event via common layer API
  var _triggerEvent = function (event, data) {
    if (_accPack) {
      _accPack.triggerEvent(event, data);
    }
  };

  var _registerEvents = function () {
    var events = [
      'startAnnotation',
      'linkAnnotation',
      'resizeCanvas',
      'annotationWindowClosed',
      'endAnnotation'
    ];

    _accPack.registerEvents(events);
  };

  var _setupUI = function () {
    var toolbar = [
      '<div id="annotationToolbarContainer" class="ots-annotation-toolbar-container">',
      '<div id="toolbar"></div>',
      '</div>'
    ].join('\n');
    $('body').append(toolbar);
    _log(_logEventData.actionUseToolbar, _logEventData.variationSuccess);
  };

  var _palette = [
    '#1abc9c',
    '#2ecc71',
    '#3498db',
    '#9b59b6',
    '#8e44ad',
    '#f1c40f',
    '#e67e22',
    '#e74c3c',
    '#ded5d5'
  ];

  var _aspectRatio = (10 / 6);

  /** Private methods */

  var _refreshCanvas = _.throttle(function () {
    _canvas.onResize();
  }, 1000);

  /** Resize the canvas to match the size of its container */
  var _resizeCanvas = function () {
    var width;
    var height;

    if (!!_elements.externalWindow) {
      var windowDimensions = {
        width: _elements.externalWindow.innerWidth,
        height: _elements.externalWindow.innerHeight
      };

      var computedHeight = windowDimensions.width / _aspectRatio;

      if (computedHeight <= windowDimensions.height) {
        width = windowDimensions.width;
        height = computedHeight;
      } else {
        height = windowDimensions.height;
        width = height * _aspectRatio;
      }
    } else {
      var el = _elements.absoluteParent || _elements.canvasContainer;
      width = $(el).width();
      height = $(el).height();
    }

    $(_elements.canvasContainer).css({
      width: width,
      height: height
    });

    $(_elements.canvasContainer).find('canvas').css({
      width: width,
      height: height
    });

    $(_elements.canvasContainer).find('canvas').attr({
      width: width,
      height: height
    });

    _refreshCanvas();
    _triggerEvent('resizeCanvas');
  };

  var _listenForResize = function () {
    $(_elements.resizeSubject).on('resize', _.throttle(function () {
      _resizeCanvas();
    }, 500));
  };

  var _createToolbar = function (session, options, externalWindow) {
    var toolbarId = _.property('toolbarId')(options) || 'toolbar';
    var items = _.property('toolbarItems')(options);
    var colors = _.property('colors')(options) || _palette;

    var container = function () {
      var w = !!externalWindow ? externalWindow : window;
      return w.document.getElementById(toolbarId);
    };

    /* eslint-disable no-native-reassign */
    toolbar = new OTSolution.Annotations.Toolbar({
      session: session,
      container: container(),
      colors: colors,
      items: !!items && !!items.length ? options.items : null,
      externalWindow: externalWindow || null,
      OTKAnalytics: OTKAnalytics
    });

    toolbar.itemClicked(function (id) {
      var actions = {
        OT_pen: _logEventData.actionFreeHand,
        OT_colors: _logEventData.actionPickerColor,
        OT_text: _logEventData.actionText,
        OT_clear: _logEventData.actionErase
      };

      var action = actions[id];

      if (!!action) {
        _log(action, _logEventData.variationSuccess);
      }
    });

    /* eslint-enable no-native-reassign */
  };

  // Create external screen sharing window
  var _createExternalWindow = function () {
    var deferred = $.Deferred();

    var width = screen.width * 0.80 | 0;
    var height = width / (_aspectRatio);
    var externalWindowHTML = '<!DOCTYPE html><html lang="en"><head><meta http-equiv="Content-type" content="text/html; charset=utf-8"><title>OpenTok Screen Sharing Solution Annotation</title><script type="text/javascript" charset="utf-8">var opener,canvas;toolbar?(opener=window.opener,window.onbeforeunload=window.triggerCloseEvent):alert("Something went wrong: You must pass an OpenTok annotation toolbar object into the window.");var createContainerElements=function(){var e=document.getElementById("annotationContainer"),n=document.createElement("div");return n.setAttribute("id","screenshare_publisher"),n.classList.add("publisher-wrap"),e.appendChild(n),{annotation:e,publisher:n}};if(-1!==navigator.userAgent.indexOf("Firefox")){var ghost=window.open("about:blank");ghost.focus(),ghost.close()}</script><style type="text/css" media="screen">    body{margin:0;background-color:rgba(0,153,203,.7);box-sizing:border-box;height:100vh}canvas{top:0;z-index:1000}.main-wrap{width:100%;height:100%;-ms-box-orient:horizontal;display:-webkit-box;display:-moz-box;display:-ms-flexbox;display:-moz-flex;display:-webkit-flex;display:flex;-webkit-justify-content:center;justify-content:center;-webkit-align-items:center;align-items:center}.inner-wrap{position:relative;border-radius:8px;overflow:hidden}.fixed-container{position:fixed;top:275px;right:0;width:40px;z-index:1001}.fixed-container .toolbar-wrap{position:absolute;top:0;left:0}.fixed-container .toolbar-wrap input{display:block;top:0!important;transform:none!important}.fixed-container .toolbar-wrap .OT_color{width:30px;margin-right:5px!important;margin-left:5px!important;padding:0}.fixed-container .toolbar-wrap .OT_subpanel,.fixed-container .toolbar-wrap .color-picker{position:absolute;top:0;right:40px;padding-left:0!important;overflow:hidden}.fixed-container .toolbar-wrap .OT_subpanel>div{top:0!important;transform:none!important}.fixed-container .toolbar-wrap .color-picker{left:-30px}.fixed-container .toolbar-wrap .color-picker .color-choice{display:block!important;height:20px!important;width:20px!important}.publisherContainer{display:block;background-color:#000;position:absolute}.OT_video-element,.publisher-wrap{height:100%;width:100%}.OT_edge-bar-item{display:none}</style></head><body>  <div class="main-wrap">    <div id="annotationContainer" class="inner-wrap"></div>  </div>  <div id="toolbarContainer" class="fixed-container">      <div id="toolbar" class="toolbar-wrap"></div>  </div></body></html>';


    var windowFeatures = [
      'toolbar=no',
      'location=no',
      'directories=no',
      'status=no',
      'menubar=no',
      'scrollbars=no',
      'resizable=no',
      'copyhistory=no', ['width=', width].join(''), ['height=', height].join(''), ['left=', ((screen.width / 2) - (width / 2))].join(''), ['top=', ((screen.height / 2) - (height / 2))].join('')
    ].join(',');


    var annotationWindow = window.open('about:blank', '', windowFeatures);
    annotationWindow.document.write(externalWindowHTML);
    window.onbeforeunload = function () {
      annotationWindow.close();
    };

    // External window needs access to certain globals
    annotationWindow.toolbar = toolbar;
    annotationWindow.OT = OT;
    annotationWindow.$ = $;

    annotationWindow.triggerCloseEvent = function () {
      _triggerEvent('annotationWindowClosed');
    };

    annotationWindow.onbeforeunload = function () {
      _triggerEvent('annotationWindowClosed');
    };

    // TODO Find something better.
    var windowReady = function () {
      if (!!annotationWindow.createContainerElements) {
        $(annotationWindow.document).ready(function () {
          deferred.resolve(annotationWindow);
        });
      } else {
        setTimeout(windowReady, 100);
      }
    };

    windowReady();

    return deferred.promise();
  };

  // Remove the toolbar and cancel event listeners
  var _removeToolbar = function () {
    $(_elements.resizeSubject).off('resize', _resizeCanvas);
    toolbar.remove();
    if (!_elements.externalWindow) {
      $('#annotationToolbarContainer').remove();
    }
  };

  /**
   * Creates an external window (if required) and links the annotation toolbar
   * to the session
   * @param {object} session
   * @param {object} [options]
   * @param {boolean} [options.screensharing] - Using an external window
   * @param {string} [options.toolbarId] - If the container has an id other than 'toolbar'
   * @param {array} [options.items] - Custom set of tools
   * @param {array} [options.colors] - Custom color palette
   * @returns {promise} < Resolve: undefined | {object} Reference to external annotation window >
   */
  var start = function (session, options) {
    var deferred = $.Deferred();

    if (_.property('screensharing')(options)) {
      _createExternalWindow()
        .then(function (externalWindow) {
          _createToolbar(session, options, externalWindow);
          toolbar.createPanel(externalWindow);
          _triggerEvent('startAnnotation', externalWindow);
          _log(_logEventData.actionStart, _logEventData.variationSuccess);
          deferred.resolve(externalWindow);
        });
    } else {
      _createToolbar(session, options);
      _triggerEvent('startAnnotation');
      _log(_logEventData.actionStart, _logEventData.variationSuccess);
      deferred.resolve();
    }

    return deferred.promise();
  };

  /**
   * @param {object} pubSub - Either the publisher(sharing) or subscriber(viewing)
   * @ param {object} container - The parent container for the canvas element
   * @ param {object} options
   * @param {object} options.canvasContainer - The id of the parent for the annotation canvas
   * @param {object} [options.externalWindow] - Reference to the annotation window if publishing
   * @param {array} [options.absoluteParent] - Reference element for resize if other than container
   */
  var linkCanvas = function (pubSub, container, options) {
    /**
     * jQuery only allows listening for a resize event on the window or a
     * jQuery resizable element, like #wmsFeedWrap.  windowRefernce is a
     * reference to the popup window created for annotation.  If this doesn't
     * exist, we are watching the canvas belonging to the party viewing the
     * shared screen
     */
    _elements.resizeSubject = _.property('externalWindow')(options) || window;
    _elements.externalWindow = _.property('externalWindow')(options) || null;
    _elements.absoluteParent = _.property('absoluteParent')(options) || null;
    _elements.canvasContainer = container;


    // The canvas object
    _canvas = new OTSolution.Annotations({
      feed: pubSub,
      container: container,
      externalWindow: _elements.externalWindow
    });

    toolbar.addCanvas(_canvas);

    _canvas.onScreenCapture(function (dataUrl) {
      var win = window.open(dataUrl, '_blank');
      win.focus();
    });


    var context = _elements.externalWindow ? _elements.externalWindow : window;
    // The canvas DOM element
    _elements.canvas = $(_.first(context.document.getElementsByTagName('canvas')));

    _listenForResize();
    _resizeCanvas();
    _triggerEvent('linkAnnotation');
  };


  var resizeCanvas = function () {
    _resizeCanvas();
  };

  /**
   * Stop annotation and clean up components
   * @param {Boolean} publisher Are we the publisher?
   */
  var end = function (publisher) {
    _removeToolbar();
    _elements.canvas = null;

    if (!!_elements.externalWindow) {
      _elements.externalWindow.close();
      _elements.externalWindow = null;
      _elements.resizeSubject = null;
    }
    _triggerEvent('endAnnotation');

    _log(_logEventData.actionEnd, _logEventData.variationSuccess);
  };
  /**
   * @constructor
   * Represents an annotation component, used for annotation over video or a shared screen
   * @param {object} options
   * @param {object} options.session - An OpenTok session
   * @param {object} options.canvasContainer - The id of the parent for the annotation canvas
   * @param {object} options.watchForResize - The DOM element to watch for resize
   */
  var AnnotationAccPack = function (options) {
    _this = this;
    _this.options = _.omit(options, 'accPack', 'session');
    _accPack = _.property('accPack')(options);
    _session = _.property('session')(options);

    if (!_session) {
      throw new Error('OpenTok Annotation Accelerator Pack requires an OpenTok session');
    }
    _registerEvents();
    // init analytics logs
    _logAnalytics();
    _log(_logEventData.actionInitialize, _logEventData.variationSuccess);
    _setupUI();
  };

  AnnotationAccPack.prototype = {
    constructor: AnnotationAccPack,
    start: start,
    linkCanvas: linkCanvas,
    resizeCanvas: resizeCanvas,
    end: end
  };

  if (typeof exports === 'object') {
    module.exports = AnnotationAccPack;
  } else if (typeof define === 'function' && define.amd) {
    define(function () {
      return AnnotationAccPack;
    });
  } else {
    this.AnnotationAccPack = AnnotationAccPack;
  }
}.call(this));
