import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const MicjohnModule = buildModule("MicjohnModule", (m) => {

    const course = m.contract("Courses");

    return { course };
});

export default MicjohnModule;