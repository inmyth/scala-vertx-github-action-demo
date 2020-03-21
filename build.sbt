name := "scala-vertx-github-action-demo"

version := "0.1"

scalaVersion := "2.12.10"

val vertxVersion = "3.8.5"
val scalaTestVersion = "3.2.0-M2"
val scalaMockVersion = "4.4.0"

libraryDependencies ++= Seq(
  "io.vertx" %% "vertx-lang-scala" % vertxVersion,
  "io.vertx" %% "vertx-web-scala" % vertxVersion,
  "org.scalatest" %% "scalatest" % scalaTestVersion % Test,
  "org.scalamock" %% "scalamock" % scalaMockVersion % Test
)