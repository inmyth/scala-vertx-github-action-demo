package me.mbcu.demo

import org.scalatest.flatspec.AnyFlatSpec

class MainTest extends AnyFlatSpec {

  behavior of "fake test"
  it should "returns true" in {
    assert(true === true)
  }

}
