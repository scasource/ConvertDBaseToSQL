unit Definitions;

interface

const
   {Comparison types}
  coEqual = 0;
  coGreaterThan = 1;
  coLessThan = 2;
  coGreaterThanOrEqual = 3;
  coLessThanOrEqual = 4;
  coNotEqual = 5;
  coBlank = 6;
  coNotBlank = 7;
  coContains = 8;
  coStartsWith = 9;
  coBetween = 10;
  coMatchesPartialOrFirstItemBlank = 11;
  coMatchesOrFirstItemBlank = 12;
  coDoesNotStartWith = 13;

    {Display Formats}
  DecimalDisplay = ',0.00';
  DecimalEditDisplay = '0.00';
  DecimalDisplay_BlankZero = ',0.00;,0.00;''';
  DecimalEditDisplay_BlankZero = '0.00;"-"0.00;''';
  NoDecimalDisplay_BlankZero = ',0.;,"-"0.;''';
  NoDecimalDisplay = '0.';
  DollarDecimalDisplay = '"$",0.';
  DollarDecimalDisplay_BlankZero = '"$",0.;"$-",0.;''';

  TimeFormat = 'hh:mm ampm';
  DateFormat = 'm/d/yyyy';
    {Ini file sections}

  sct_Components ='COMPONENTS';

  emEdit = 'M';
  emInsert = 'A';
  emBrowse = 'V';
  emDelete = 'D';

type
  TLocateOptionTypes = (loPartialKey, loChangeIndex, loSameEndingRange);
  TLocateOptions = set of TLocateOptionTypes;

  TTableOpenOptionTypes = (toExclusive, toReadOnly, toOpenAsIs, toNoReopen);
  TTableOpenOptions = set of TTableOpenOptionTypes;

  TInsertRecordOptionTypes = (irSuppressInitializeFields, irSuppressPost);
  TInsertRecordOptions = set of TInsertRecordOptionTypes;

var
  GlblCurrentCommaDelimitedField : Integer;

implementation

initialization
  GlblCurrentCommaDelimitedField := 0;

end.
