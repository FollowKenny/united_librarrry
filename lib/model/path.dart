class AppRoutePath {
  final bool isLoggedIn;
  final String? authAction;
  final String? libraryUid;
  final bool isUnknown;


  AppRoutePath.loggedOut()
    : isLoggedIn = false,
      libraryUid = null,
      isUnknown = false,
      authAction = null;
  
  AppRoutePath.auth(this.authAction)
    : isLoggedIn = false,
      isUnknown = false,
      libraryUid = null;

  AppRoutePath.libraries()
    : isLoggedIn = true,
      isUnknown = false,
      libraryUid = null,
      authAction = null;

  AppRoutePath.library(this.libraryUid)
    : isLoggedIn = true,
      isUnknown = false,
      authAction = null;
  
  AppRoutePath.unknown()
    : isLoggedIn = false,
      libraryUid = null,
      authAction = null,
      isUnknown = true;
}