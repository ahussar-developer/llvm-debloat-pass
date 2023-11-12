#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;
using namespace std;

namespace {
    struct DebloatPass : public ModulePass {
        static char ID;

        DebloatPass() : ModulePass(ID) {}
        PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM);

        void getAnalysisUsage(AnalysisUsage &AU) const
        {
            AU.addRequired<LoopInfoWrapperPass>();
        }

        bool runOnModule(Module &M) override;
    };
}

bool DebloatPass::runOnModule(Module &M) {

  for (auto &F : M) {
    errs() << F.getName().str() << "\n";
  }

  errs() << "--------PASS COMPLETED--------\n";

  //return true if pass modified code
  return false;
}

PreservedAnalyses DebloatPass::run(Module &M,ModuleAnalysisManager &AM) {
  bool Changed = runOnModule(M);

  return (Changed ? llvm::PreservedAnalyses::none() : llvm::PreservedAnalyses::all());
}

char DebloatPass::ID = 0;
static RegisterPass<DebloatPass> Y("dp-pass", "DebloatPass");