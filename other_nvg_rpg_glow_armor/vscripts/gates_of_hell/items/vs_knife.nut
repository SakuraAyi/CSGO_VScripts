class knife_Properties
{
    entityClass = "knife";
    viewmodel = "predicted_viewmodel";
    worldmodel = "weaponworldmodel";
    Vmodel = ModelList[19];
    Wmodel = ModelList[20];
};

class knive extends knife_Properties
{
    handle = null;
    constructor (handle = null)
    {
        this.handle = handle;
    }

    table = {};

    function run ()
    {
        local ent;
        while ((ent = Entities.FindByClassname(ent, "*")) != null)
        {
            if (ent.GetClassname().find(entityClass) > 0)
            {
                local xx = "xxx";
                local l_knife = ent;
                if (l_knife.GetMoveParent() != null)
                {
                    if (l_knife.GetName() != xx)
                    {
                        BaseVS(l_knife).SetKeyValue("classname", xx);
                        l_knife.SetModel(Vmodel);
                        BaseVS(l_knife).SetBodyGroup(1);
                    }
                }
            }

            if (ent.GetMoveParent() != null)
            {
                local _parent = ent.GetMoveParent();
                local _sc = _parent.GetScriptScope();
                if (_parent == handle)
                {
                    if (ent.GetClassname() == viewmodel)
                    {
                        if (!("vm_isKnife" in _sc))
                            _sc.vm_isKnife <- 0;

                        local l_view = ent;
                        local l_vmodel = l_view.GetModelName();

                        if (l_vmodel.find(entityClass) > 0)
                        {
                            if (!_sc.vm_isKnife)
                                _sc.vm_isKnife <- true;

                            l_view.SetModel(Vmodel);
                            l_vmodel = Vmodel;
                            BaseVS(l_view).SetBodyGroup(1);
                        }
                        else
                        {
                            if (l_vmodel != Vmodel)
                            {
                                if (_sc.vm_isKnife)
                                    _sc.vm_isKnife <- false;
                            }
                        }

                        //all weapon and item draw sounds
                        
                        local _id = _sc.userid.tostring();
                        if (!(_id in this.table))
                        {
                            table[_id] <- {previous = null};
                        }
                        else
                        {
                            if (table[_id].previous != l_vmodel)
                            {
                                script_item.GetScriptScope().items.DrawSound(_parent, l_vmodel);
                                table[_id].previous <- l_vmodel;
                            }
                        }

                    }
                    else if (ent.GetClassname() == worldmodel)
                    {
                        local l_wmodel = ent;
                        if (l_wmodel.GetModelName().find(entityClass) > 0)
                        {
                            l_wmodel.SetModel(Wmodel);
                            BaseVS(l_wmodel).SetBodyGroup(1);
                        }
                    }

                    //return;
                }
            }
        }
    }
};