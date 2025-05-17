package sharpTPU

import spinal.core._
import spinal.core.sim._

object Config {
  def spinal = SpinalConfig(
    targetDirectory = "hw/gen",
    defaultConfigForClockDomains = ClockDomainConfig(
      resetActiveLevel = LOW,
      resetKind = SYNC
    ),
    onlyStdLogicVectorAtTopLevelIo = false
  )
  def sim = SimConfig.withConfig(spinal).withFstWave
}
