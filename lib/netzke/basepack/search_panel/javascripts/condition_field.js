Ext.define('Netzke.classes.Netzke.Basepack.SearchPanel.ConditionField', {
  extend:     'Ext.form.FieldContainer',
  alias:      'widget.netzkebasepacksearchpanelconditionfield',

  hideLabel:  true,
  layout:     'hbox',

  // Config refinements for the value field
  valueFieldConfigs: {
    string: {
      xtype : 'textfield'
    },
    datetime: {
      xtype : 'datefield'
    },
    date: {
      xtype : 'datefield'
    },
    integer: {
      xtype: 'numberfield'
    }
  },

  initComponent: function(){
    if (!this.attrType || this.assoc) this.attrType = 'string';

    this.attrTypeHash = {};

    var storeData = Ext.Array.map(this.ownerCt.attrs, function(attr) {
      this.attrTypeHash[attr.name] = attr.attrType;
      return [attr.name, attr.text];
    }, this);

    var items = [
      // attribute combo
      {
        xtype     : 'combo',
        store: storeData,
        allowBlank: true,
        // store: [],
        name: this.attr + '_attr',
        itemId: 'attrCombo',
        emptyText: '属性',
        triggerAction: 'all',
        value: this.attr ? this.attr.underscore() : "",
        listeners: {
          select: this.onAttributeChange,
          scope: this
        }
      }
    ];

    if (this.attr) {

      var operators = this.ownerCt.attributeOperatorsMap[this.attrType] || [[]];

      if (this.attrType === 'boolean') {
        items.push({
          xtype     : 'tricheckbox',
          width: 100,
          name: this.attr + '_value',
          itemId: 'valueField',
          checked: this.value
        });

        items.push({
          flex: 1,
          xtype: 'displayfield'
        });
      } else {
        // operator combo
        items.push(
          {
            width:      100,
            xtype:      'combo',
            fieldLabel: 'Operator',
            hideLabel:  true,
            store:      operators,
            name:       this.attr + '_operator',
            value:      this.operator || operators[0][0],
            autoSelect: true,
            triggerAction: 'all',
            emptyText:  "Operator",
            itemId:     "operatorCombo"
          }
        );

        // value field
        items.push(Ext.apply(
          {
            xtype: 'textfield',
            emptyText: "Value",
            flex: 1,
            name: this.attr + '_value',
            value: this.value,
            itemId: "valueField"
          },
          this.valueFieldConfigs[this.attrType] // refining the config dependent on the attr type
        ));
      }

      // delete button
      items.push({
        xtype: 'button',
        cls: 'x-btn-icon',
        icon: Netzke.RelativeUrlRoot + "/images/icons/cross.png",
        handler: this.removeSelf,
        scope: this
      });
    }

    this.items = items;

    // Why on Earth is this not working? Netzke.classes.Netzke.Basepack.SearchPanel.ConditionField undefined???
    // Netzke.classes.Basepack.SearchPanel.ConditionField.superclass.initComponent.call(this);
    // Ext.form.CompositeField.prototype.initComponent.call(this); // workaround
    this.callParent();

    this.attrCombo = this.getComponent('attrCombo');
    this.operatorCombo = this.getComponent('operatorCombo');
    this.valueField = this.getComponent('valueField');

    this.addEvents('configured'); // user selects the attribute from the attribute combo
  },

  isConfigured: function() {
    return !!this.attrCombo.getValue();
  },

  removeSelf: function(){
    var ownerCt = this.ownerCt;
    this.destroy();
    ownerCt.fireEvent('fieldsnumberchange');
  },

  onAttributeChange: function(e){
    this.fireEvent('configured');
    this.changeAttribute(e.value);
  },

  // Dynamically replace self with a field with different attrType
  changeAttribute: function(attr){
    var attrType = this.attrTypeHash[attr];
    var idx = this.ownerCt.items.indexOf(this);
    var owner = this.ownerCt;
    var newSelf = Ext.createByAlias('widget.netzkebasepacksearchpanelconditionfield', Ext.apply(this.initialConfig, {name: attr, attrType: attrType, attr: attr.underscore(), ownerCt: this.ownerCt, operator: null}));
    owner.remove(this);
    owner.insert(idx, newSelf);
    owner.doLayout();
  },

  // Returns true if it should be in the query
  valueIsSet: function(){
    return !!(this.attrCombo.getValue() && (this.attrType === 'boolean' || this.operatorCombo.getValue()) && !Ext.isEmpty(this.valueField.getValue()));
  },

  // Returns the query object
  buildValue: function(){
    var res = {attr: this.attrCombo.getValue(), value: this.valueField.getValue()};
    if (this.attrType !== 'boolean') {
      res.operator = this.operatorCombo.getValue();
    }
    return res;
  },

  clearValue: function() {
    this.valueField.reset();
  }

});
