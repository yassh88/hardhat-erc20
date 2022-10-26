module.exports = async ({ getNamedAccounts, deployments }) => {
  const { deploy } = deployments
  const { deployer } = await getNamedAccounts()
  const args = [30, "Yashwant", "YSR"]
  await deploy("ManualTokens", {
    from: deployer,
    args,
    log: true,
  })
}
module.exports.tags = ["ManualTokens"]
