// This code was auto-generated, is not intended to be edited, and is subject to
// significant change. Please see the README file for more information.

library engine.source;

import 'java_core.dart';
import 'sdk.dart' show DartSdk;
import 'engine.dart' show AnalysisContext;

/**
 * Instances of interface `LocalSourcePredicate` are used to determine if the given
 * [Source] is "local" in some sense, so can be updated.
 *
 * @coverage dart.engine.source
 */
abstract class LocalSourcePredicate {
  /**
   * Instance of [LocalSourcePredicate] that always returns `false`.
   */
  static final LocalSourcePredicate FALSE = new LocalSourcePredicate_15();

  /**
   * Instance of [LocalSourcePredicate] that always returns `true`.
   */
  static final LocalSourcePredicate TRUE = new LocalSourcePredicate_16();

  /**
   * Instance of [LocalSourcePredicate] that returns `true` for all [Source]s
   * except of SDK.
   */
  static final LocalSourcePredicate NOT_SDK = new LocalSourcePredicate_17();

  /**
   * Determines if the given [Source] is local.
   *
   * @param source the [Source] to analyze
   * @return `true` if the given [Source] is local
   */
  bool isLocal(Source source);
}

class LocalSourcePredicate_15 implements LocalSourcePredicate {
  bool isLocal(Source source) => false;
}

class LocalSourcePredicate_16 implements LocalSourcePredicate {
  bool isLocal(Source source) => true;
}

class LocalSourcePredicate_17 implements LocalSourcePredicate {
  bool isLocal(Source source) => source.uriKind != UriKind.DART_URI;
}

/**
 * Instances of the class `SourceFactory` resolve possibly relative URI's against an existing
 * [Source].
 *
 * @coverage dart.engine.source
 */
class SourceFactory {
  /**
   * The analysis context that this source factory is associated with.
   */
  AnalysisContext context;

  /**
   * A cache of content used to override the default content of a source.
   */
  ContentCache contentCache;

  /**
   * The resolvers used to resolve absolute URI's.
   */
  List<UriResolver> _resolvers;

  /**
   * The predicate to determine is [Source] is local.
   */
  LocalSourcePredicate _localSourcePredicate;

  /**
   * Initialize a newly created source factory.
   *
   * @param contentCache the cache holding content used to override the default content of a source
   * @param resolvers the resolvers used to resolve absolute URI's
   */
  SourceFactory.con1(ContentCache contentCache, List<UriResolver> resolvers) {
    this.contentCache = contentCache;
    this._resolvers = resolvers;
    this._localSourcePredicate = LocalSourcePredicate.NOT_SDK;
  }

  /**
   * Initialize a newly created source factory.
   *
   * @param resolvers the resolvers used to resolve absolute URI's
   */
  SourceFactory.con2(List<UriResolver> resolvers) : this.con1(new ContentCache(), resolvers);

  /**
   * Return a source object representing the given absolute URI, or `null` if the URI is not a
   * valid URI or if it is not an absolute URI.
   *
   * @param absoluteUri the absolute URI to be resolved
   * @return a source object representing the absolute URI
   */
  Source forUri(String absoluteUri) {
    try {
      Uri uri = parseUriWithException(absoluteUri);
      if (uri.isAbsolute) {
        return resolveUri2(null, uri);
      }
    } on URISyntaxException catch (exception) {
    }
    return null;
  }

  /**
   * Return a source object that is equal to the source object used to obtain the given encoding.
   *
   * @param encoding the encoding of a source object
   * @return a source object that is described by the given encoding
   * @throws IllegalArgumentException if the argument is not a valid encoding
   * @see Source#getEncoding()
   */
  Source fromEncoding(String encoding) {
    if (encoding.length < 2) {
      throw new IllegalArgumentException("Invalid encoding length");
    }
    UriKind kind = UriKind.fromEncoding(encoding.codeUnitAt(0));
    if (kind == null) {
      throw new IllegalArgumentException("Invalid source kind in encoding: ${kind}");
    }
    try {
      Uri uri = parseUriWithException(encoding.substring(1));
      for (UriResolver resolver in _resolvers) {
        Source result = resolver.fromEncoding(contentCache, kind, uri);
        if (result != null) {
          return result;
        }
      }
      throw new IllegalArgumentException("No resolver for kind: ${kind}");
    } on JavaException catch (exception) {
      throw new IllegalArgumentException("Invalid URI in encoding");
    }
  }

  /**
   * Return the [DartSdk] associated with this [SourceFactory], or `null` if there
   * is no such SDK.
   *
   * @return the [DartSdk] associated with this [SourceFactory], or `null` if
   *         there is no such SDK
   */
  DartSdk get dartSdk {
    for (UriResolver resolver in _resolvers) {
      if (resolver is DartUriResolver) {
        DartUriResolver dartUriResolver = resolver as DartUriResolver;
        return dartUriResolver.dartSdk;
      }
    }
    return null;
  }

  /**
   * Determines if the given [Source] is local.
   *
   * @param source the [Source] to analyze
   * @return `true` if the given [Source] is local
   */
  bool isLocalSource(Source source) => _localSourcePredicate.isLocal(source);

  /**
   * Return a source object representing the URI that results from resolving the given (possibly
   * relative) contained URI against the URI associated with an existing source object, or
   * `null` if either the contained URI is invalid or if it cannot be resolved against the
   * source object's URI.
   *
   * @param containingSource the source containing the given URI
   * @param containedUri the (possibly relative) URI to be resolved against the containing source
   * @return the source representing the contained URI
   */
  Source resolveUri(Source containingSource, String containedUri) {
    if (containedUri == null || containedUri.isEmpty) {
      return null;
    }
    try {
      return resolveUri2(containingSource, parseUriWithException(containedUri));
    } on URISyntaxException catch (exception) {
      return null;
    }
  }

  /**
   * Return an absolute URI that represents the given source.
   *
   * @param source the source to get URI for
   * @return the absolute URI representing the given source, may be `null`
   */
  Uri restoreUri(Source source) {
    for (UriResolver resolver in _resolvers) {
      Uri uri = resolver.restoreAbsolute(source);
      if (uri != null) {
        return uri;
      }
    }
    return null;
  }

  /**
   * Set the contents of the given source to the given contents. This has the effect of overriding
   * the default contents of the source. If the contents are `null` the override is removed so
   * that the default contents will be returned.
   *
   * @param source the source whose contents are being overridden
   * @param contents the new contents of the source
   * @return the original cached contents or `null` if none
   */
  String setContents(Source source, String contents) => contentCache.setContents(source, contents);

  /**
   * Sets the [LocalSourcePredicate].
   *
   * @param localSourcePredicate the predicate to determine is [Source] is local
   */
  void set localSourcePredicate(LocalSourcePredicate localSourcePredicate) {
    this._localSourcePredicate = localSourcePredicate;
  }

  /**
   * Return the contents of the given source, or `null` if this factory does not override the
   * contents of the source.
   *
   * <b>Note:</b> This method is not intended to be used except by
   * [FileBasedSource#getContents].
   *
   * @param source the source whose content is to be returned
   * @return the contents of the given source
   */
  String getContents(Source source) => contentCache.getContents(source);

  /**
   * Return the modification stamp of the given source, or `null` if this factory does not
   * override the contents of the source.
   *
   * <b>Note:</b> This method is not intended to be used except by
   * [FileBasedSource#getModificationStamp].
   *
   * @param source the source whose modification stamp is to be returned
   * @return the modification stamp of the given source
   */
  int getModificationStamp(Source source) => contentCache.getModificationStamp(source);

  /**
   * Return a source object representing the URI that results from resolving the given (possibly
   * relative) contained URI against the URI associated with an existing source object, or
   * `null` if either the contained URI is invalid or if it cannot be resolved against the
   * source object's URI.
   *
   * @param containingSource the source containing the given URI
   * @param containedUri the (possibly relative) URI to be resolved against the containing source
   * @return the source representing the contained URI
   */
  Source resolveUri2(Source containingSource, Uri containedUri) {
    if (containedUri.isAbsolute) {
      for (UriResolver resolver in _resolvers) {
        Source result = resolver.resolveAbsolute(contentCache, containedUri);
        if (result != null) {
          return result;
        }
      }
      return null;
    } else {
      return containingSource.resolveRelative(containedUri);
    }
  }
}

/**
 * The abstract class `UriResolver` defines the behavior of objects that are used to resolve
 * URI's for a source factory. Subclasses of this class are expected to resolve a single scheme of
 * absolute URI.
 *
 * @coverage dart.engine.source
 */
abstract class UriResolver {
  /**
   * If this resolver should be used for URI's of the given kind, resolve the given absolute URI.
   * The URI does not need to have the scheme handled by this resolver if the kind matches. Return a
   * [Source] representing the file to which it was resolved, or `null` if it
   * could not be resolved.
   *
   * @param contentCache the content cache used to access the contents of the returned source
   * @param kind the kind of URI that was originally resolved in order to produce an encoding with
   *          the given URI
   * @param uri the URI to be resolved
   * @return a [Source] representing the file to which given URI was resolved
   */
  Source fromEncoding(ContentCache contentCache, UriKind kind, Uri uri);

  /**
   * Resolve the given absolute URI. Return a [Source] representing the file to which
   * it was resolved, or `null` if it could not be resolved.
   *
   * @param contentCache the content cache used to access the contents of the returned source
   * @param uri the URI to be resolved
   * @return a [Source] representing the file to which given URI was resolved
   */
  Source resolveAbsolute(ContentCache contentCache, Uri uri);

  /**
   * Return an absolute URI that represents the given source.
   *
   * @param source the source to get URI for
   * @return the absolute URI representing the given source, may be `null`
   */
  Uri restoreAbsolute(Source source) => null;
}

/**
 * The interface `Source` defines the behavior of objects representing source code that can be
 * compiled.
 *
 * @coverage dart.engine.source
 */
abstract class Source {
  /**
   * An empty array of sources.
   */
  static final List<Source> EMPTY_ARRAY = new List<Source>(0);

  /**
   * Return `true` if the given object is a source that represents the same source code as
   * this source.
   *
   * @param object the object to be compared with this object
   * @return `true` if the given object is a source that represents the same source code as
   *         this source
   * @see Object#equals(Object)
   */
  bool operator ==(Object object);

  /**
   * Return `true` if this source exists.
   *
   * @return `true` if this source exists
   */
  bool exists();

  /**
   * Get the contents of this source and pass it to the given receiver. Exactly one of the methods
   * defined on the receiver will be invoked unless an exception is thrown. The method that will be
   * invoked depends on which of the possible representations of the contents is the most efficient.
   * Whichever method is invoked, it will be invoked before this method returns.
   *
   * @param receiver the content receiver to which the content of this source will be passed
   * @throws Exception if the contents of this source could not be accessed
   */
  void getContents(Source_ContentReceiver receiver);

  /**
   * Return an encoded representation of this source that can be used to create a source that is
   * equal to this source.
   *
   * @return an encoded representation of this source
   * @see SourceFactory#fromEncoding(String)
   */
  String get encoding;

  /**
   * Return the full (long) version of the name that can be displayed to the user to denote this
   * source. For example, for a source representing a file this would typically be the absolute path
   * of the file.
   *
   * @return a name that can be displayed to the user to denote this source
   */
  String get fullName;

  /**
   * Return the modification stamp for this source. A modification stamp is a non-negative integer
   * with the property that if the contents of the source have not been modified since the last time
   * the modification stamp was accessed then the same value will be returned, but if the contents
   * of the source have been modified one or more times (even if the net change is zero) the stamps
   * will be different.
   *
   * @return the modification stamp for this source
   */
  int get modificationStamp;

  /**
   * Return a short version of the name that can be displayed to the user to denote this source. For
   * example, for a source representing a file this would typically be the name of the file.
   *
   * @return a name that can be displayed to the user to denote this source
   */
  String get shortName;

  /**
   * Return the kind of URI from which this source was originally derived. If this source was
   * created from an absolute URI, then the returned kind will reflect the scheme of the absolute
   * URI. If it was created from a relative URI, then the returned kind will be the same as the kind
   * of the source against which the relative URI was resolved.
   *
   * @return the kind of URI from which this source was originally derived
   */
  UriKind get uriKind;

  /**
   * Return a hash code for this source.
   *
   * @return a hash code for this source
   * @see Object#hashCode()
   */
  int get hashCode;

  /**
   * Return `true` if this source is in one of the system libraries.
   *
   * @return `true` if this is in a system library
   */
  bool get isInSystemLibrary;

  /**
   * Resolve the relative URI against the URI associated with this source object. Return a
   * [Source] representing the URI to which it was resolved, or `null` if it
   * could not be resolved.
   *
   * Note: This method is not intended for public use, it is only visible out of necessity. It is
   * only intended to be invoked by a [SourceFactory]. Source factories will
   * only invoke this method if the URI is relative, so implementations of this method are not
   * required to, and generally do not, verify the argument. The result of invoking this method with
   * an absolute URI is intentionally left unspecified.
   *
   * @param relativeUri the relative URI to be resolved against the containing source
   * @return a [Source] representing the URI to which given URI was resolved
   */
  Source resolveRelative(Uri relativeUri);
}

/**
 * The interface `ContentReceiver` defines the behavior of objects that can receive the
 * content of a source.
 */
abstract class Source_ContentReceiver {
  /**
   * Accept the contents of a source represented as a character buffer.
   *
   * @param contents the contents of the source
   * @param modificationTime the time at which the contents were last set
   */
  void accept(CharBuffer contents, int modificationTime);

  /**
   * Accept the contents of a source represented as a string.
   *
   * @param contents the contents of the source
   * @param modificationTime the time at which the contents were last set
   */
  void accept2(String contents, int modificationTime);
}

/**
 * The enumeration `SourceKind` defines the different kinds of sources that are known to the
 * analysis engine.
 *
 * @coverage dart.engine.source
 */
class SourceKind extends Enum<SourceKind> {
  /**
   * A source containing HTML. The HTML might or might not contain Dart scripts.
   */
  static final SourceKind HTML = new SourceKind('HTML', 0);

  /**
   * A Dart compilation unit that is not a part of another library. Libraries might or might not
   * contain any directives, including a library directive.
   */
  static final SourceKind LIBRARY = new SourceKind('LIBRARY', 1);

  /**
   * A Dart compilation unit that is part of another library. Parts contain a part-of directive.
   */
  static final SourceKind PART = new SourceKind('PART', 2);

  /**
   * An unknown kind of source. Used both when it is not possible to identify the kind of a source
   * and also when the kind of a source is not known without performing a computation and the client
   * does not want to spend the time to identify the kind.
   */
  static final SourceKind UNKNOWN = new SourceKind('UNKNOWN', 3);

  static final List<SourceKind> values = [HTML, LIBRARY, PART, UNKNOWN];

  SourceKind(String name, int ordinal) : super(name, ordinal);
}

/**
 * The enumeration `UriKind` defines the different kinds of URI's that are known to the
 * analysis engine. These are used to keep track of the kind of URI associated with a given source.
 *
 * @coverage dart.engine.source
 */
class UriKind extends Enum<UriKind> {
  /**
   * A 'dart:' URI.
   */
  static final UriKind DART_URI = new UriKind('DART_URI', 0, 0x64);

  /**
   * A 'file:' URI.
   */
  static final UriKind FILE_URI = new UriKind('FILE_URI', 1, 0x66);

  /**
   * A 'package:' URI referencing source package itself.
   */
  static final UriKind PACKAGE_SELF_URI = new UriKind('PACKAGE_SELF_URI', 2, 0x73);

  /**
   * A 'package:' URI.
   */
  static final UriKind PACKAGE_URI = new UriKind('PACKAGE_URI', 3, 0x70);

  static final List<UriKind> values = [DART_URI, FILE_URI, PACKAGE_SELF_URI, PACKAGE_URI];

  /**
   * Return the URI kind represented by the given encoding, or `null` if there is no kind with
   * the given encoding.
   *
   * @param encoding the single character encoding used to identify the URI kind to be returned
   * @return the URI kind represented by the given encoding
   */
  static UriKind fromEncoding(int encoding) {
    while (true) {
      if (encoding == 0x64) {
        return DART_URI;
      } else if (encoding == 0x66) {
        return FILE_URI;
      } else if (encoding == 0x73) {
        return PACKAGE_SELF_URI;
      } else if (encoding == 0x70) {
        return PACKAGE_URI;
      }
      break;
    }
    return null;
  }

  /**
   * The single character encoding used to identify this kind of URI.
   */
  int encoding = 0;

  /**
   * Initialize a newly created URI kind to have the given encoding.
   *
   * @param encoding the single character encoding used to identify this kind of URI.
   */
  UriKind(String name, int ordinal, int encoding) : super(name, ordinal) {
    this.encoding = encoding;
  }
}

/**
 * A source range defines an [Element]'s source coordinates relative to its [Source].
 *
 * @coverage dart.engine.utilities
 */
class SourceRange {
  /**
   * An empty [SourceRange] with offset `0` and length `0`.
   */
  static SourceRange EMPTY = new SourceRange(0, 0);

  /**
   * The 0-based index of the first character of the source code for this element, relative to the
   * source buffer in which this element is contained.
   */
  int offset = 0;

  /**
   * The number of characters of the source code for this element, relative to the source buffer in
   * which this element is contained.
   */
  int length = 0;

  /**
   * Initialize a newly created source range using the given offset and the given length.
   *
   * @param offset the given offset
   * @param length the given length
   */
  SourceRange(int offset, int length) {
    this.offset = offset;
    this.length = length;
  }

  /**
   * @return `true` if <code>x</code> is in [offset, offset + length) interval.
   */
  bool contains(int x) => offset <= x && x < offset + length;

  /**
   * @return `true` if <code>x</code> is in (offset, offset + length) interval.
   */
  bool containsExclusive(int x) => offset < x && x < offset + length;

  /**
   * @return `true` if <code>otherRange</code> covers this [SourceRange].
   */
  bool coveredBy(SourceRange otherRange) => otherRange.covers(this);

  /**
   * @return `true` if this [SourceRange] covers <code>otherRange</code>.
   */
  bool covers(SourceRange otherRange) => offset <= otherRange.offset && otherRange.end <= end;

  /**
   * @return `true` if this [SourceRange] ends in <code>otherRange</code>.
   */
  bool endsIn(SourceRange otherRange) {
    int thisEnd = end;
    return otherRange.contains(thisEnd);
  }

  bool operator ==(Object obj) {
    if (obj is! SourceRange) {
      return false;
    }
    SourceRange sourceRange = obj as SourceRange;
    return sourceRange.offset == offset && sourceRange.length == length;
  }

  /**
   * @return the 0-based index of the after-last character of the source code for this element,
   *         relative to the source buffer in which this element is contained.
   */
  int get end => offset + length;

  /**
   * @return the expanded instance of [SourceRange], which has the same center.
   */
  SourceRange getExpanded(int delta) => new SourceRange(offset - delta, delta + length + delta);

  /**
   * @return the instance of [SourceRange] with end moved on "delta".
   */
  SourceRange getMoveEnd(int delta) => new SourceRange(offset, length + delta);

  /**
   * @return the expanded translated of [SourceRange], with moved start and the same length.
   */
  SourceRange getTranslated(int delta) => new SourceRange(offset + delta, length);

  int get hashCode => 31 * offset + length;

  /**
   * @return `true` if this [SourceRange] intersects with given.
   */
  bool intersects(SourceRange other) {
    if (other == null) {
      return false;
    }
    if (end <= other.offset) {
      return false;
    }
    if (offset >= other.end) {
      return false;
    }
    return true;
  }

  /**
   * @return `true` if this [SourceRange] starts in <code>otherRange</code>.
   */
  bool startsIn(SourceRange otherRange) => otherRange.contains(offset);

  String toString() {
    JavaStringBuilder builder = new JavaStringBuilder();
    builder.append("[offset=");
    builder.append(offset);
    builder.append(", length=");
    builder.append(length);
    builder.append("]");
    return builder.toString();
  }
}

/**
 * The interface `SourceContainer` is used by clients to define a collection of sources
 *
 * Source containers are not used within analysis engine, but can be used by clients to group
 * sources for the purposes of accessing composite dependency information. For example, the Eclipse
 * client uses source containers to represent Eclipse projects, which allows it to easily compute
 * project-level dependencies.
 *
 * @coverage dart.engine.source
 */
abstract class SourceContainer {
  /**
   * Determine if the specified source is part of the receiver's collection of sources.
   *
   * @param source the source in question
   * @return `true` if the receiver contains the source, else `false`
   */
  bool contains(Source source);
}

/**
 * Instances of the class `DartUriResolver` resolve `dart` URI's.
 *
 * @coverage dart.engine.source
 */
class DartUriResolver extends UriResolver {
  /**
   * The Dart SDK against which URI's are to be resolved.
   */
  DartSdk dartSdk;

  /**
   * The name of the `dart` scheme.
   */
  static String _DART_SCHEME = "dart";

  /**
   * Return `true` if the given URI is a `dart:` URI.
   *
   * @param uri the URI being tested
   * @return `true` if the given URI is a `dart:` URI
   */
  static bool isDartUri(Uri uri) => _DART_SCHEME == uri.scheme;

  /**
   * Initialize a newly created resolver to resolve Dart URI's against the given platform within the
   * given Dart SDK.
   *
   * @param sdk the Dart SDK against which URI's are to be resolved
   */
  DartUriResolver(DartSdk sdk) {
    this.dartSdk = sdk;
  }

  Source fromEncoding(ContentCache contentCache, UriKind kind, Uri uri) {
    if (identical(kind, UriKind.DART_URI)) {
      return dartSdk.fromEncoding(contentCache, kind, uri);
    }
    return null;
  }

  Source resolveAbsolute(ContentCache contentCache, Uri uri) {
    if (!isDartUri(uri)) {
      return null;
    }
    return dartSdk.mapDartUri(uri.toString());
  }
}

/**
 * Instances of the class `LineInfo` encapsulate information about line and column information
 * within a source file.
 *
 * @coverage dart.engine.utilities
 */
class LineInfo {
  /**
   * An array containing the offsets of the first character of each line in the source code.
   */
  List<int> _lineStarts;

  /**
   * Initialize a newly created set of line information to represent the data encoded in the given
   * array.
   *
   * @param lineStarts the offsets of the first character of each line in the source code
   */
  LineInfo(List<int> lineStarts) {
    if (lineStarts == null) {
      throw new IllegalArgumentException("lineStarts must be non-null");
    } else if (lineStarts.length < 1) {
      throw new IllegalArgumentException("lineStarts must be non-empty");
    }
    this._lineStarts = lineStarts;
  }

  /**
   * Return the location information for the character at the given offset.
   *
   * @param offset the offset of the character for which location information is to be returned
   * @return the location information for the character at the given offset
   */
  LineInfo_Location getLocation(int offset) {
    int lineCount = _lineStarts.length;
    for (int i = 1; i < lineCount; i++) {
      if (offset < _lineStarts[i]) {
        return new LineInfo_Location(i, offset - _lineStarts[i - 1] + 1);
      }
    }
    return new LineInfo_Location(lineCount, offset - _lineStarts[lineCount - 1] + 1);
  }
}

/**
 * Instances of the class `Location` represent the location of a character as a line and
 * column pair.
 */
class LineInfo_Location {
  /**
   * The one-based index of the line containing the character.
   */
  int lineNumber = 0;

  /**
   * The one-based index of the column containing the character.
   */
  int columnNumber = 0;

  /**
   * Initialize a newly created location to represent the location of the character at the given
   * line and column position.
   *
   * @param lineNumber the one-based index of the line containing the character
   * @param columnNumber the one-based index of the column containing the character
   */
  LineInfo_Location(int lineNumber, int columnNumber) {
    this.lineNumber = lineNumber;
    this.columnNumber = columnNumber;
  }
}

/**
 * Instances of class `ContentCache` hold content used to override the default content of a
 * [Source].
 *
 * @coverage dart.engine.source
 */
class ContentCache {
  /**
   * A table mapping sources to the contents of those sources. This is used to override the default
   * contents of a source.
   */
  Map<Source, String> _contentMap = new Map<Source, String>();

  /**
   * A table mapping sources to the modification stamps of those sources. This is used when the
   * default contents of a source has been overridden.
   */
  Map<Source, int> _stampMap = new Map<Source, int>();

  /**
   * Return the contents of the given source, or `null` if this cache does not override the
   * contents of the source.
   *
   * <b>Note:</b> This method is not intended to be used except by
   * [SourceFactory#getContents].
   *
   * @param source the source whose content is to be returned
   * @return the contents of the given source
   */
  String getContents(Source source) => _contentMap[source];

  /**
   * Return the modification stamp of the given source, or `null` if this cache does not
   * override the contents of the source.
   *
   * <b>Note:</b> This method is not intended to be used except by
   * [SourceFactory#getModificationStamp].
   *
   * @param source the source whose modification stamp is to be returned
   * @return the modification stamp of the given source
   */
  int getModificationStamp(Source source) => _stampMap[source];

  /**
   * Set the contents of the given source to the given contents. This has the effect of overriding
   * the default contents of the source. If the contents are `null` the override is removed so
   * that the default contents will be returned.
   *
   * @param source the source whose contents are being overridden
   * @param contents the new contents of the source
   * @return the original cached contents or `null` if none
   */
  String setContents(Source source, String contents) {
    if (contents == null) {
      _stampMap.remove(source);
      return _contentMap.remove(source);
    } else {
      _stampMap[source] = JavaSystem.currentTimeMillis();
      return javaMapPut(_contentMap, source, contents);
    }
  }
}