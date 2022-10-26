const { getNamedAccounts } = require("hardhat")
const { assert, expect } = require("chai")

describe("ERC20", () => {
  let deployer, ysrTokens, accounts
  beforeEach(async () => {
    deployer = (await getNamedAccounts()).deployer
    await deployments.fixture("ManualTokens")
    ysrTokens = await ethers.getContract("ManualTokens", deployer)
    accounts = await ethers.getSigners()
  })
  it("check is deployed", async () => {
    const name = await ysrTokens.getName()
    assert.equal(name, "Yashwant")
    const symbol = await ysrTokens.getSymbol()
    assert.equal(symbol, "YSR")
    let supply = await ysrTokens.getTotalSupply()
    supply = supply.toString()
    console.log("supply", supply)
    assert.equal(supply, 30)
  })
  it.only("add approval", async () => {
    const txResponse = await ysrTokens.approve(accounts[2].address, 10)
    const txReceipt = await txResponse.wait(1) // waits 1 block
    const [_owner, _spender, _value] = txReceipt.events[0].args
    assert.equal(_value.toString(), 10)
    assert.equal(_value.toString(), 10)
  })
  it("transferfrom", async () => {
    await expect(
      ysrTokens.transfer(accounts[1].address, 10)
    ).to.be.revertedWith("0x1")
  })
  it("transferfrom", async () => {
    const txResponse = await ysrTokens.transfer(accounts[1].address, 10)
    const txReceipt = await txResponse.wait(1) // waits 1 block
    expect(await ysrTokens.balanceOf(accounts[1].address)).to.equal(10)
  })
  it("emits an transfer event, when an transfer occurs", async () => {
    await expect(
      ysrTokens.transfer(accounts[1].address, 40)
    ).to.be.revertedWith("")
  })
})
