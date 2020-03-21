package me.mbcu.demo

import io.vertx.scala.core.Vertx

import scala.util.{Failure, Success}

object Main extends App {

  import scala.concurrent.ExecutionContext.Implicits.global

  val vertx = Vertx.vertx()
  val port = 8080
  vertx.createHttpServer().requestHandler(req => {
    req.response().putHeader("content-type", "application/json")
    req.response().end("{\"message\":\"Martin Test\"}")
  })
    .listenFuture(port).onComplete {
    case Success(_) => println(s"Server is now listening at $port")

    case Failure(cause) =>
      println(cause.getMessage)
      System.exit(0)
  }

}
