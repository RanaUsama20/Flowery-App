import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@module
abstract class LoggerModule {
  @lazySingleton
  Logger get loggerProvider => Logger(
        level: Level.all,
        output: ConsoleOutput(),
        printer: prettyPrinter,
      );

  @lazySingleton
  PrettyPrinter get prettyPrinter => PrettyPrinter(
        printEmojis: true,
        lineLength: 180,
        levelEmojis: {
          Level.all: '📢',
          Level.trace: '👣',
          Level.debug: '🐞',
          Level.info: 'ℹ️',
          Level.warning: '⚠️',
          Level.error: '❌',
          Level.fatal: '💀',
          Level.off: '🛑',
        },
      );
}
