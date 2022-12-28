enum AuthResultStatus {
  successful,
  emailAlreadyExists,
  emailIsNotVerified,
  wrongPassword,
  invalidEmail,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  tooManyRequests,
  undefined,
  weakpassword,
  networkRequestIssue
}

class AuthExceptionHandler {
  static handleException(e) {
    // print(e.code);
    AuthResultStatus status;

    switch (e.code) {
      case "invalid-email":
        status = AuthResultStatus.invalidEmail;
        break;
      case "wrong-password":
        status = AuthResultStatus.wrongPassword;
        break;
      case "user-not-found":
        status = AuthResultStatus.userNotFound;
        break;
      case "user-disabled":
        status = AuthResultStatus.userDisabled;
        break;
      case "too-many-requests":
        status = AuthResultStatus.tooManyRequests;
        break;
      case "operation-not-allowed":
        status = AuthResultStatus.operationNotAllowed;
        break;
      case "email-already-in-use":
        status = AuthResultStatus.emailAlreadyExists;
        break;
      case "weak-password":
        status = AuthResultStatus.weakpassword;
        break;
      case "network-request-failed":
        status = AuthResultStatus.networkRequestIssue;
        break;
      default:
        status = AuthResultStatus.undefined;
    }
    return status;
  }

  ///
  /// Accepts AuthExceptionHandler.errorType
  ///
  static generateExceptionMessage(exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
      case AuthResultStatus.invalidEmail:
        errorMessage = "Your email address appears to be malformed.";
        errorMessage = "e" + errorMessage;
        break;
      case AuthResultStatus.wrongPassword:
        errorMessage = "Wrong password, please try again or click forget.";
        errorMessage = "p" + errorMessage;
        break;
      case AuthResultStatus.userNotFound:
        errorMessage = "User with this email doesn't exist.";
        errorMessage = "e" + errorMessage;
        break;
      case AuthResultStatus.userDisabled:
        errorMessage = "User with this email has been disabled.";
        errorMessage = "e" + errorMessage;
        break;
      case AuthResultStatus.tooManyRequests:
        errorMessage = "Too many requests. Try again later.";
        break;
      case AuthResultStatus.operationNotAllowed:
        errorMessage = "Signing in with Email and Password is not enabled.";
        break;
      case AuthResultStatus.emailAlreadyExists:
        errorMessage = "The email has already been registered.";
        errorMessage = "e" + errorMessage;
        break;
      case AuthResultStatus.weakpassword:
        errorMessage = "Password is too weak";
        errorMessage = "p" + errorMessage;
        break;
      case AuthResultStatus.networkRequestIssue:
        errorMessage = "Check your internet connection";
        break;
      default:
        errorMessage = "An undefined Error happened.";
    }

    return errorMessage;
  }
}
