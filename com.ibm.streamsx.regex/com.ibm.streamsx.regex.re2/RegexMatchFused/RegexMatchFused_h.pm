
package RegexMatchFused_h;
use strict; use Cwd 'realpath';  use File::Basename;  use lib dirname(__FILE__);  use SPL::Operator::Instance::OperatorInstance; use SPL::Operator::Instance::Context; use SPL::Operator::Instance::Expression; use SPL::Operator::Instance::ExpressionTree; use SPL::Operator::Instance::ExpressionTreeVisitor; use SPL::Operator::Instance::ExpressionTreeCppGenVisitor; use SPL::Operator::Instance::InputAttribute; use SPL::Operator::Instance::InputPort; use SPL::Operator::Instance::OutputAttribute; use SPL::Operator::Instance::OutputPort; use SPL::Operator::Instance::Parameter; use SPL::Operator::Instance::StateVariable; use SPL::Operator::Instance::Window; 
sub main::generate($$) {
   my ($xml, $signature) = @_;  
   print "// $$signature\n";
   my $model = SPL::Operator::Instance::OperatorInstance->new($$xml);
   unshift @INC, dirname ($model->getContext()->getOperatorDirectory()) . "/../impl/nl/include";
   $SPL::CodeGenHelper::verboseMode = $model->getContext()->isVerboseModeOn();
   print '#include <string>', "\n";
   print '#include <streams_boost/ptr_container/ptr_unordered_map.hpp>', "\n";
   print '#include "re2/re2.h"', "\n";
   print "\n";
   SPL::CodeGen::headerPrologue($model);
   print "\n";
   print "\n";
   print 'using namespace std;', "\n";
   print 'using streams_boost::ptr_unordered_map;', "\n";
   print "\n";
   print 'class MY_OPERATOR : public MY_BASE_OPERATOR ', "\n";
   print '{', "\n";
   print 'public:', "\n";
   print '  MY_OPERATOR();', "\n";
   print '  virtual ~MY_OPERATOR(); ', "\n";
   print "\n";
   print '  void process(Tuple & tuple, uint32_t port);', "\n";
   print "\n";
   print 'private:', "\n";
   print '  RE2::Options _options;', "\n";
   print '  RE2 _regex;', "\n";
   print "\n";
   print '  Mutex _mutex;', "\n";
   print '  ptr_unordered_map<string,RE2> _regexMap;', "\n";
   print "\n";
   print '  bool regexFullMatch(const string & str);', "\n";
   print '  bool regexFullMatch(const string & str, const string & pattern);', "\n";
   print '  bool regexPartialMatch(const string & str);', "\n";
   print '  bool regexPartialMatch(const string & str, const string & pattern);', "\n";
   print '  bool regexSimpleMatch(const string & str);', "\n";
   print '  bool regexSimpleMatch(const string & str, const string & pattern);', "\n";
   print '}; ', "\n";
   print "\n";
   SPL::CodeGen::headerEpilogue($model);
   print "\n";
   CORE::exit $SPL::CodeGen::USER_ERROR if ($SPL::CodeGen::sawError);
}
1;
