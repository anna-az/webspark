class SendUrlPending {
  const SendUrlPending(this.url);
  final String url;
}

class SendUrlSuccess {}

class SendUrlError {
  const SendUrlError(this.error);
  final dynamic error;
}
